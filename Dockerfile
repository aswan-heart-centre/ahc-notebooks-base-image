FROM python:3.11-slim-bookworm

WORKDIR /home/jovyan/work

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    # build-essentials \
    && rm  -rf /var/lib/apt/lists*

RUN useradd -m -s /bin/bash jovyan && \
    mkdir -p /home/jovyan/work/notebooks

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

USER jovyan
RUN mkdir /home/jovyan/work/notebooks
WORKDIR /home/jovyan/work/notebooks

