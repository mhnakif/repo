FROM nvcr.io/nvidia/pytorch:25.11-py3

# Comfy
COPY requirements/comfy.txt /tmp/requirements-comfy.txt
RUN pip install --no-cache-dir -r /tmp/requirements-comfy.txt \
  && pip install --no-cache-dir --no-deps torchaudio

# Aria2
RUN pip install --no-cache-dir aria2
