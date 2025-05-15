# Use Python 3.6 or later as a base image
ARG PYTHON_VERSION
FROM python:${PYTHON_VERSION:-3.8}
# Copy contents into image
WORKDIR /app
COPY . . 
# Install pip dependencies from requirements
RUN pip install -r requirements.txt
# Set YOUR_NAME environment variable
ARG AUTHOR
LABEL author=${AUTHOR}
LABEL description="an app..."
ENV NAME="Emma"
# Expose the correct port
EXPOSE 5500
# Create an entrypoint
ENTRYPOINT ["python", "app.py"]
