FROM nvcr.io/nvidia/pytorch:25.11-py3

# Aria2
RUN pip install --no-cache-dir aria2

# code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

COPY code-server.tar /tmp/code-server.tar
RUN mkdir -p /root/.local/share/code-server \
  && tar -xf /tmp/code-server.tar -C /root/.local/share/code-server


# Comfy and extensions
COPY requirements/ /tmp/requirements/
RUN pip install --no-cache-dir -r /tmp/requirements/comfy.txt \    
  && pip install --no-cache-dir -r /tmp/requirements/easyuse.txt \
  && pip install --no-cache-dir -r /tmp/requirements/kjnodes.txt \
  && pip install --no-cache-dir -r /tmp/requirements/videohelper.tx \
  && pip install --no-cache-dir --no-deps torchaudio


# Install helper scripts and make them available in PATH.
COPY scripts/ /workspace/scripts/
RUN chmod +x /workspace/scripts/*
ENV PATH="/workspace/scripts:${PATH}"
