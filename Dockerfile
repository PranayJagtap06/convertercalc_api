# Use the official Python image as the base image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /code

# Copy the requirements file into the container
COPY ./requirements.txt /code/requirements.txt

# Install the Python dependencies
RUN pip install --no-cache-dir -r /code/requirements.txt

# Copy the entire project into the container
COPY ./app /code/app

# Expose the port that the FastAPI app will run on
EXPOSE 80

# Set the command to run the FastAPI app
CMD ["fastapi", "run", "app/main.py",  "--host", "0.0.0.0", "--port", "80"]
