FROM python:3.12-slim

# System deps (for yt-dlp, image ops, etc.)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# Install Python deps
RUN pip install --no-cache-dir -r requirements.txt

# Railway exposes its own port
ENV PORT=8080

# Use Gunicorn with Uvicorn worker (ASGI)
CMD ["gunicorn", "-k", "uvicorn.workers.UvicornWorker", "-b", "0.0.0.0:${PORT}", "app:app"]
