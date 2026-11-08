-- Order-state tracking. Payload shape not verified against the live broker.
CREATE WORKER 'localhost:8080' SET ('localhost:19090' AS DATA);

CREATE LOGICAL SOURCE ORDERS(
    "ts" VARSIZED,
    "state" VARSIZED,
    "type" VARSIZED
);

CREATE PHYSICAL SOURCE FOR ORDERS TYPE MQTT SET(
    'localhost:8080' AS "SOURCE"."HOST",
    'tcp://localhost:11883' AS "SOURCE"."SERVER_URI",
    'f/i/order' AS "SOURCE"."TOPIC",
    2 AS "SOURCE"."QOS",
    100 AS "SOURCE"."FLUSH_INTERVAL_MS",
    'JSON' AS "INPUT_FORMATTER"."TYPE"
);

CREATE SINK ORDERS_SINK(
    "ts" VARSIZED,
    "state" VARSIZED,
    "type" VARSIZED
) TYPE File SET(
    'localhost:8080' AS "SINK"."HOST",
    'fisher_sink/factory_order.jsonl' AS "SINK"."FILE_PATH",
    'JSON' AS "SINK"."OUTPUT_FORMAT"
);

SELECT
    "ts",
    "state",
    "type"
FROM ORDERS
INTO ORDERS_SINK;
