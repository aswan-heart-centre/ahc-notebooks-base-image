FROM python:3.11-slim-bookworm

# Set environment variables for locale
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Create jovyan user and working directories
RUN useradd -m -s /bin/bash jovyan && \
    mkdir -p /home/jovyan/work/notebooks && \
    chown -R jovyan:jovyan /home/jovyan

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    git \
    build-essential \
    libgl1-mesa-glx \
    libglib2.0-0 \
    ttf-dejavu \
    locales \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen

USER jovyan

WORKDIR /home/jovyan/work/notebooks
