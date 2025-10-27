FROM python:3.8-slim-buster

# Update sources list to use archive repositories
RUN sed -i s/deb.debian.org/archive.debian.org/g /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org/|g' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list
WORKDIR /app
COPY . /app
COPY . /app

# Fix apt commands - combine and add error handling
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    awscli \
    ffmpeg \
    libsm6 \
    libxext6 \
    unzip && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN pip install -r requirements.txt


CMD ["python3", "app.py"]
