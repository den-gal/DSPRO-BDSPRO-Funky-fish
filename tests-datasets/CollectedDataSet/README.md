# Run Projection Queries NES

This directory contains projection NES queries and the resulting JSON file
sinks.

Start the single-node-worker (you can also add options, by default it uses 4
worker threads, and JIT Compilation mode):

```bash
$SINGLE_NODE_WORKER_PATH/nes-single-node-worker -- \
    --grpc=localhost:8080 --data_address=localhost:19090
```

Submit one query:

```bash
cmake-build-debug/nes-frontend/apps/nes-repl < fisher_queries/bme680.sql
```

Submit all of the queries:

```bash
for f in fisher_queries/*.sql; do cmake-build-debug/nes-frontend/apps/nes-repl < $f; done
```
