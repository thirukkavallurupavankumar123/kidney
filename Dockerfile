FROM python:3.9-slim-bullseye

# Install system dependencies
RUN apt-get update -y && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy requirements first for caching
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Run with gunicorn
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:10000"]
