# Use the official Nginx image as the base image
FROM nginx:latest

# Install Python and dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the FastAPI application code
COPY . /app
WORKDIR /app

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx and the FastAPI application
CMD service nginx start && uvicorn main:app --host 0.0.0.0 --port 8000