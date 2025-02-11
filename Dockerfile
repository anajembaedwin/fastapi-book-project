# Use the official Nginx image as the base image
FROM nginx:latest

# Install Python and dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a virtual environment using Python 3
RUN python3 -m venv /app/venv

# Verify the virtual environment
RUN ls /app/venv/bin

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the FastAPI application code
COPY . /app
WORKDIR /app

# Install Python dependencies in the virtual environment
RUN /app/venv/bin/python3 -m pip install --upgrade pip && \
    /app/venv/bin/python3 -m pip install -r requirements.txt

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx and the FastAPI application
CMD service nginx start && /app/venv/bin/uvicorn main:app --host 0.0.0.0 --port 8000
