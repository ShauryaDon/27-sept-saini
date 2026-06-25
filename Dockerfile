FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=1

WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y \
    ffmpeg \
    aria2 \
    wget \
    unzip \
    build-essential \
    cmake \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Bento4
RUN wget -q https://github.com/axiomatic-systems/Bento4/releases/download/v1.6.0-641/Bento4-SDK-1-6-0-641.x86_64-unknown-linux.zip \
    && unzip Bento4-SDK-1-6-0-641.x86_64-unknown-linux.zip \
    && cp Bento4-SDK-1-6-0-641.x86_64-unknown-linux/bin/mp4decrypt /usr/local/bin/ \
    && chmod +x /usr/local/bin/mp4decrypt \
    && rm -rf Bento4*

RUN pip install --upgrade pip setuptools wheel

RUN pip install -r sainibots.txt

RUN pip install -U yt-dlp

CMD ["python","modules/main.py"]
