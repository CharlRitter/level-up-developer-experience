FROM python:3.9-slim

# Prevent Python from writing .pyc files to disc.
ENV PYTHONDONTWRITEBYTECODE 1
# Ensure stdout and stderr are flushed immediately.
ENV PYTHONUNBUFFERED 1

WORKDIR /app

# Install dependencies.
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy project source code.
COPY . /app/

# Expose the port Django will run on.
EXPOSE 8000

# Run the Django app using Gunicorn.
CMD ["gunicorn", "myproject.wsgi:application", "--bind", "0.0.0.0:8000"]
