FROM python:3.11-slim-bookworm

RUN useradd -m -s /bin/bash jovyan && \
    mkdir -p /home/jovyan/work/notebooks && \
    chown -R jovyan:jovyan /home/jovyan

WORKDIR /home/jovyan/work

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    bash \
    && rm  -rf /var/lib/apt/lists*

USER jovyan

WORKDIR /home/jovyan/work/notebooks 

