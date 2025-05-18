# Dockerfile
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y git cmake build-essential python3 python3-pip && \
    pip3 install fastapi uvicorn requests

WORKDIR /app
RUN git clone --recursive https://github.com/microsoft/BitNet.git

WORKDIR /app/BitNet
RUN mkdir build && cd build && cmake .. && make -j$(nproc)

# Copy over API wrapper
COPY bitnet_api.py /app/bitnet_api.py

EXPOSE 8000

CMD ["uvicorn", "bitnet_api:app", "--host", "0.0.0.0", "--port", "8000"]
