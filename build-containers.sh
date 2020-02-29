#!/bin/bash
docker buildx build --platform linux/arm -f Dockerfile_py3 -t adiibanez/arm7-py3-runtime . --push
docker buildx build --platform linux/arm -f Dockerfile -t adiibanez/tf-audio-runtime . --push