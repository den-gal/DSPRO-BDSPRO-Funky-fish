-- Pan/tilt position of the camera mount.
CREATE WORKER 'localhost:8080' SET ('localhost:19090' AS DATA);

CREATE LOGICAL SOURCE PTU_POS(
    "ts" VARSIZED NOT NULL,
    "pan" FLOAT64 NOT NULL,
    "tilt" FLOAT64 NOT NULL
);

CREATE PHYSICAL SOURCE FOR PTU_POS TYPE MQTT SET(
    'localhost:8080' AS "SOURCE"."HOST",
    'tcp://localhost:11883' AS "SOURCE"."SERVER_URI",
    'i/ptu/pos' AS "SOURCE"."TOPIC",
    2 AS "SOURCE"."QOS",
    100 AS "SOURCE"."FLUSH_INTERVAL_MS",
    'JSON' AS "INPUT_FORMATTER"."TYPE"
);

CREATE SINK PTU_POS_SINK(
    "ts" VARSIZED NOT NULL,
    "pan" FLOAT64 NOT NULL,
    "tilt" FLOAT64 NOT NULL
) TYPE File SET(
    'localhost:8080' AS "SINK"."HOST",
    'fisher_sink/factory_ptu_pos.jsonl' AS "SINK"."FILE_PATH",
    'JSON' AS "SINK"."OUTPUT_FORMAT"
);

SELECT
    "ts",
    "pan",
    "tilt"
FROM PTU_POS
INTO PTU_POS_SINK;
