sudo docker run --rm -it \
  --gpus all \
  --ipc=host \
  --ulimit memlock=-1 \
  --ulimit stack=67108864 \
  -p 28188:8188 \
  -p 28080:8080 \
  --tmpfs /workspace/scratch:size=200G \
  mhnakif/repo:latest
