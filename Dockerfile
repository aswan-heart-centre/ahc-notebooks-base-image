FROM python:3.11-slim-bookworm

# Set environment variables for locale
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Create jovyan user and working directories
RUN useradd -m -s /bin/bash jovyan && \
    mkdir -p /home/jovyan/work/notebooks && \
    chown -R jovyan:jovyan /home/jovyan

# Install Python packages
COPY requirements.txt /home/jovyan/work/notebooks/requirements.txt
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r /home/jovyan/work/notebooks/requirements.txt
RUN pip install plotly-calplot==0.1.20 --no-deps


USER jovyan

WORKDIR /home/jovyan/work/notebooks
