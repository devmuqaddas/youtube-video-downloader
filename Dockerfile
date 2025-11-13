FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port (Railway auto assigns $PORT)
EXPOSE 8080

# Run FastAPI with Gunicorn + UvicornWorker
CMD ["gunicorn", "app:app", "-k", "uvicorn.workers.UvicornWorker", "-b", "0.0.0.0:8080"]
