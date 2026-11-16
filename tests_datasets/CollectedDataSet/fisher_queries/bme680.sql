-- BME680 environmental sensor on the HBW base plate. Drops rt, rh and gr, which the sensor always reports as 0.
CREATE WORKER 'localhost:8080' SET ('localhost:19090' AS DATA);

CREATE LOGICAL SOURCE BME680(
    "ts" VARSIZED NOT NULL,
    "t" FLOAT64 NOT NULL,
    "rt" FLOAT64 NOT NULL,
    "h" FLOAT64 NOT NULL,
    "rh" FLOAT64 NOT NULL,
    "p" FLOAT64 NOT NULL,
    "iaq" FLOAT64 NOT NULL,
    "aq" UINT64 NOT NULL,
    "gr" FLOAT64 NOT NULL
);

CREATE PHYSICAL SOURCE FOR BME680 TYPE MQTT SET(
    'localhost:8080' AS "SOURCE"."HOST",
    'tcp://localhost:11883' AS "SOURCE"."SERVER_URI",
    'i/bme680' AS "SOURCE"."TOPIC",
    2 AS "SOURCE"."QOS",
    100 AS "SOURCE"."FLUSH_INTERVAL_MS",
    'JSON' AS "INPUT_FORMATTER"."TYPE"
);

CREATE SINK BME680_SINK(
    "ts" VARSIZED NOT NULL,
    "t" FLOAT64 NOT NULL,
    "h" FLOAT64 NOT NULL,
    "p" FLOAT64 NOT NULL,
    "iaq" FLOAT64 NOT NULL,
    "aq" UINT64 NOT NULL
) TYPE File SET(
    'localhost:8080' AS "SINK"."HOST",
    'fisher_sink/factory_bme680.jsonl' AS "SINK"."FILE_PATH",
    'JSON' AS "SINK"."OUTPUT_FORMAT"
);

SELECT
    "ts",
    "t",
    "h",
    "p",
    "iaq",
    "aq"
FROM BME680
INTO BME680_SINK;
