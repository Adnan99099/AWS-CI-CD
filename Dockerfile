FROM python:3.8-slim-bullseye
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
