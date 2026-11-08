-- Same NFC reader, read directly off the TXT's I2C bus. Payload shape not verified against the live broker.
CREATE WORKER 'localhost:8080' SET ('localhost:19090' AS DATA);

CREATE LOGICAL SOURCE NFC_DS_LOCAL(
    "ts" VARSIZED,
    "workpiece/id" VARSIZED,
    "workpiece/type" VARSIZED,
    "workpiece/state" VARSIZED
);

CREATE PHYSICAL SOURCE FOR NFC_DS_LOCAL TYPE MQTT SET(
    'localhost:8080' AS "SOURCE"."HOST",
    'tcp://localhost:11883' AS "SOURCE"."SERVER_URI",
    'fl/i/nfc/ds' AS "SOURCE"."TOPIC",
    2 AS "SOURCE"."QOS",
    100 AS "SOURCE"."FLUSH_INTERVAL_MS",
    'JSON' AS "INPUT_FORMATTER"."TYPE"
);

CREATE SINK NFC_DS_LOCAL_SINK(
    "ts" VARSIZED,
    "workpiece_id" VARSIZED,
    "workpiece_type" VARSIZED,
    "workpiece_state" VARSIZED
) TYPE File SET(
    'localhost:8080' AS "SINK"."HOST",
    'fisher_sink/factory_nfc_ds_local.jsonl' AS "SINK"."FILE_PATH",
    'JSON' AS "SINK"."OUTPUT_FORMAT"
);

SELECT
    "ts",
    "workpiece/id" AS "workpiece_id",
    "workpiece/type" AS "workpiece_type",
    "workpiece/state" AS "workpiece_state"
FROM NFC_DS_LOCAL
INTO NFC_DS_LOCAL_SINK;
