-- TXT controller identity/keep-alive; fires on connect, then rarely. Topic and payload shape not verified against the live broker.
CREATE WORKER 'localhost:8080' SET ('localhost:19090' AS DATA);

CREATE LOGICAL SOURCE BROADCAST(
    "ts" VARSIZED,
    "hardwareId" VARSIZED,
    "hardwareModel" VARSIZED,
    "softwareName" VARSIZED,
    "softwareVersion" VARSIZED,
    "message" VARSIZED
);

CREATE PHYSICAL SOURCE FOR BROADCAST TYPE MQTT SET(
    'localhost:8080' AS "SOURCE"."HOST",
    'tcp://localhost:11883' AS "SOURCE"."SERVER_URI",
    'f/i/broadcast' AS "SOURCE"."TOPIC",
    2 AS "SOURCE"."QOS",
    100 AS "SOURCE"."FLUSH_INTERVAL_MS",
    'JSON' AS "INPUT_FORMATTER"."TYPE"
);

CREATE SINK BROADCAST_SINK(
    "ts" VARSIZED,
    "hardwareId" VARSIZED,
    "hardwareModel" VARSIZED,
    "softwareName" VARSIZED,
    "softwareVersion" VARSIZED,
    "message" VARSIZED
) TYPE File SET(
    'localhost:8080' AS "SINK"."HOST",
    'fisher_sink/factory_broadcast.jsonl' AS "SINK"."FILE_PATH",
    'JSON' AS "SINK"."OUTPUT_FORMAT"
);

SELECT
    "ts",
    "hardwareId",
    "hardwareModel",
    "softwareName",
    "softwareVersion",
    "message"
FROM BROADCAST
INTO BROADCAST_SINK;
