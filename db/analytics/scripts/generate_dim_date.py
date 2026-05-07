#!/usr/bin/env python3
"""
Generate batched INSERT INTO statements for the aux.dim_date table.
Each year has a separate INSERT containing all its dates.
"""

from datetime import date, timedelta
import hashlib

# ---------------- PARAMETERS ----------------
YEARS = list(range(2020, 2031))  # years to generate
TABLE_NAME = "aux.dim_date"      # target table
OUTPUT_FILE = "dim_date_inserts.sql"  # output SQL file
# ------------------------------------------

MONTH_NAMES_IT = {
    1: "Gennaio",
    2: "Febbraio",
    3: "Marzo",
    4: "Aprile",
    5: "Maggio",
    6: "Giugno",
    7: "Luglio",
    8: "Agosto",
    9: "Settembre",
    10: "Ottobre",
    11: "Novembre",
    12: "Dicembre",
}


def md5_of_date(d: date) -> str:
    return hashlib.md5(d.isoformat().encode("utf-8")).hexdigest()


def is_weekend(d: date) -> bool:
    return d.weekday() >= 5


def quarter_of_month(month: int) -> int:
    return (month - 1) // 3 + 1

def year_month(year: int, month: int) -> str:
    return f"{year}-{month:02d}"

def format_value(d: date) -> str:
    """Return the tuple values for a single row in SQL"""
    date_str = d.isoformat()
    date_pk = md5_of_date(d)
    y = d.year
    m = d.month
    ym = year_month(y,m)
    q = quarter_of_month(m)
    day = d.day
    month_name = MONTH_NAMES_IT[m]
    weekend = 'true' if is_weekend(d) else 'false'
    return f"('{date_pk}', DATE '{date_str}', {y}, {q}, {m}, '{ym}', '{month_name}', {day}, {weekend}, CURRENT_TIMESTAMP)"


def daterange(start_date: date, end_date: date):
    delta = end_date - start_date
    for i in range(delta.days + 1):
        yield start_date + timedelta(days=i)


def main():
    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        f.write(f"-- Batched INSERTs per year for {TABLE_NAME}\n\n")
        for y in sorted(YEARS):
            start = date(y, 1, 1)
            end = date(y, 12, 31)
            values = [format_value(d) for d in daterange(start, end)]
            f.write(
                f"DELETE FROM {TABLE_NAME} WHERE year = {y};\n"
                f"INSERT INTO {TABLE_NAME} "
                f"(date_pk, calendar_date, year, quarter, month, year_month, month_name, day, is_weekend, processed_time)\n"
                f"VALUES\n  {',\n  '.join(values)};\n\n"
            )
    print(f"SQL file generated: {OUTPUT_FILE}")


if __name__ == "__main__":
    main()
