FROM nvcr.io/nvidia/pytorch:25.11-py3

# Comfy
COPY requirements/comfy.txt /tmp/requirements-comfy.txt
RUN pip install --no-cache-dir -r /tmp/requirements-comfy.txt \
  && pip install --no-cache-dir --no-deps torchaudio

# Aria2
RUN pip install --no-cache-dir aria2

# code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

COPY code-server.tar /tmp/code-server.tar
RUN mkdir -p /root/.local/share/code-server \
  && tar -xf /tmp/code-server.tar -C /root/.local/share/code-server

# Install helper scripts and make them available in PATH.
COPY scripts/ /workspace/scripts/
RUN chmod +x /workspace/scripts/*
ENV PATH="/workspace/scripts:${PATH}"
