docker build . --tag ${REGISTRY}/${USERNAME}/${IMAGE_NAME?Variable not set} && \
docker run ${REGISTRY}/${USERNAME}/${IMAGE_NAME?Variable not set}
docker push ${REGISTRY}/${USERNAME}/${IMAGE_NAME?Variable not set}
