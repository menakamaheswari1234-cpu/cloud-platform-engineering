FROM python:3.12-slim
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
WORKDIR /app
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app/ .
RUN useradd -u 10001 -m appuser
USER 10001
EXPOSE 8080
HEALTHCHECK CMD python -c "import urllib.request;urllib.request.urlopen('http://localhost:8080/healthz')"
CMD ["gunicorn", "-b", "0.0.0.0:8080", "app:app"]
