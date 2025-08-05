FROM python:3.11-slim

# Install build dependencies
RUN apt-get update && apt-get install -y build-essential gcc && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the Pipfile and Pipfile.lock
COPY Pipfile Pipfile.lock ./

# Install dependencies using pipenv
RUN pip install pipenv && pipenv install --system --deploy --ignore-pipfile

# Copy the rest of the application code
COPY . .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]