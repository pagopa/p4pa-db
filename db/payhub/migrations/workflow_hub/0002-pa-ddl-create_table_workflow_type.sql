-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS workflow_hub.workflow_type_id_seq;

CREATE TABLE IF NOT EXISTS workflow_hub.workflow_type
(
    workflow_type_id bigint NOT NULL DEFAULT nextval('workflow_hub.workflow_type_id_seq'),
    description text NOT NULL,
    default_execution_config jsonb NOT NULL,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    CONSTRAINT workflow_type_pkey PRIMARY KEY (workflow_type_id)
);

INSERT INTO workflow_hub.workflow_type
       (workflow_type_id, description          , update_operator_external_id,
        default_execution_config)
SELECT  -1              , 'Fine Debt Positions', 'SYSTEM'                   ,
       ('{"workflowTypeName": "fineWf", "discountDays": 5, "expirationDays": 60, '||
        '"ioMessages": {'||
              '"notified": {"subject": "Notifica multa", "message": "Gentile utente, in data %dataNotifica% risulta esserle stata inviata una notifica di pagamento per una multa. Paga l''avviso avente codice %avvisoRidotto_NAV% entro %fineRiduzione% per beneficiare dell''importo ridotto pari a %avvisoRidotto_importo%. Oltre tale data l''importo dovuto sarà %avvisoIntero_importo%"}, '||
              '"reductionExpired": {"subject": "Scadenza riduzione multa", "message": "Gentile utente, il periodo di riduzione del precedente avviso (codice %avvisoRidotto_NAV%) non è più disponibile. Ha tempo fino a %posizioneDebitoria_scadenza% per procedere al pagamento del nuovo avviso avente codice %avvisoIntero_NAV% ed importo pari a %avvisoIntero_importo%."}' ||
        '}}')::jsonb
WHERE NOT EXISTS(SELECT * FROM workflow_hub.workflow_type WHERE workflow_type_id=-1);

-- final commit
COMMIT;