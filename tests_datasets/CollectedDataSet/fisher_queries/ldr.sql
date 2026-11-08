-- Photoresistor wired to the TXT controller.
CREATE WORKER 'localhost:8080' SET ('localhost:19090' AS DATA);

CREATE LOGICAL SOURCE LDR(
    "ts" VARSIZED NOT NULL,
    "br" FLOAT64 NOT NULL,
    "ldr" UINT64 NOT NULL
);

CREATE PHYSICAL SOURCE FOR LDR TYPE MQTT SET(
    'localhost:8080' AS "SOURCE"."HOST",
    'tcp://localhost:11883' AS "SOURCE"."SERVER_URI",
    'i/ldr' AS "SOURCE"."TOPIC",
    2 AS "SOURCE"."QOS",
    100 AS "SOURCE"."FLUSH_INTERVAL_MS",
    'JSON' AS "INPUT_FORMATTER"."TYPE"
);

CREATE SINK LDR_SINK(
    "ts" VARSIZED NOT NULL,
    "br" FLOAT64 NOT NULL,
    "ldr" UINT64 NOT NULL
) TYPE File SET(
    'localhost:8080' AS "SINK"."HOST",
    'fisher_sink/factory_ldr.jsonl' AS "SINK"."FILE_PATH",
    'JSON' AS "SINK"."OUTPUT_FORMAT"
);

SELECT
    "ts",
    "br",
    "ldr"
FROM LDR
INTO LDR_SINK;
