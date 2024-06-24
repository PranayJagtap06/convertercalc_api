# Use the official Python image as the base image
FROM python:3.11-alpine

# Create a non-root user with a specific UID
RUN adduser -D -u 10001 appuser

# Set the working directory in the container
WORKDIR /code

# Copy the requirements file into the container
COPY ./requirements.txt /code/requirements.txt

# Install the Python dependencies
RUN pip install --no-cache-dir -r /code/requirements.txt

# Copy the entire project into the container
COPY ./api /code/api

# Change ownership of the working directory to the non-root user
RUN chown -R appuser:appuser /code

# Switch to the non-root user
USER 10001

# Expose the port that the FastAPI app will run on
EXPOSE 8080

# Set the command to run the FastAPI app
CMD ["fastapi", "run", "api/main.py",  "--host", "0.0.0.0", "--port", "8080"]
