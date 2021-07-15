#!/bin/bash

### Fluent Bit configuration parameters (defaults)
## Service section
export FLB_SERVICE_FLUSH=${FLB_SERVICE_FLUSH:-"1"}
export FLB_SERVICE_GRACE=${FLB_SERVICE_GRACE:-"30"}
export FLB_SERVICE_LOG_LEVEL=${FLB_SERVICE_LOG_LEVEL:-"info"}
## Input section
export FLB_INPUT_MEM_BUF_LIMIT=${FLB_INPUT_MEM_BUF_LIMIT:-"100MB"}

### Collect EC2 and ECS metadata
export EC2_INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
export ECS_METADATA=$(curl -s ${ECS_CONTAINER_METADATA_URI_V4})
export ECS_CLUSTER=$(echo ${ECS_METADATA} | python -c "import json, sys; print(json.load(sys.stdin)['Labels']['com.amazonaws.ecs.cluster'])")
export ECS_TASK_ARN=$(echo ${ECS_METADATA} | python -c "import json, sys; print(json.load(sys.stdin)['Labels']['com.amazonaws.ecs.task-arn'])")
export ECS_TASK_DEFINITION_FAMILY=$(echo ${ECS_METADATA} | python -c "import json, sys; print(json.load(sys.stdin)['Labels']['com.amazonaws.ecs.task-definition-family'])")
export ECS_TASK_DEFINITION_VERSION=$(echo ${ECS_METADATA} | python -c "import json, sys; print(json.load(sys.stdin)['Labels']['com.amazonaws.ecs.task-definition-version'])")
export ECS_IMAGE_VERSION=$(echo ${ECS_METADATA} | python -c "import json, sys; print(json.load(sys.stdin)['Image'].split(':')[-1])")
export ECS_TASK_DEFINITION="${ECS_TASK_DEFINITION_FAMILY}:${ECS_TASK_DEFINITION_VERSION}"

exec /fluent-bit/bin/fluent-bit -e /fluent-bit/firehose.so -e /fluent-bit/cloudwatch.so -e /fluent-bit/kinesis.so -c /fluent-bit/alt/fluent-bit.conf
