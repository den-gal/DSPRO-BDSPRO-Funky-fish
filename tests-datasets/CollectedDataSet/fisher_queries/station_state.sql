-- Status of all six stations; the wildcard covers f/i/state/<station>, the payload carries the station name.
CREATE WORKER 'localhost:8080' SET ('localhost:19090' AS DATA);

CREATE LOGICAL SOURCE STATION_STATE(
    "ts" VARSIZED NOT NULL,
    "station" VARSIZED NOT NULL,
    "code" INT64 NOT NULL,
    "description" VARSIZED,
    "active" BOOLEAN NOT NULL,
    "target" VARSIZED
);

CREATE PHYSICAL SOURCE FOR STATION_STATE TYPE MQTT SET(
    'localhost:8080' AS "SOURCE"."HOST",
    'tcp://localhost:11883' AS "SOURCE"."SERVER_URI",
    'f/i/state/+' AS "SOURCE"."TOPIC",
    2 AS "SOURCE"."QOS",
    100 AS "SOURCE"."FLUSH_INTERVAL_MS",
    'JSON' AS "INPUT_FORMATTER"."TYPE"
);

CREATE SINK STATION_STATE_SINK(
    "ts" VARSIZED NOT NULL,
    "station" VARSIZED NOT NULL,
    "code" INT64 NOT NULL,
    "active" BOOLEAN NOT NULL,
    "target" VARSIZED
) TYPE File SET(
    'localhost:8080' AS "SINK"."HOST",
    'fisher_sink/factory_station_state.jsonl' AS "SINK"."FILE_PATH",
    'JSON' AS "SINK"."OUTPUT_FORMAT"
);

SELECT
    "ts",
    "station",
    "code",
    "active",
    "target"
FROM STATION_STATE
INTO STATION_STATE_SINK;
