FROM python:3.7.1-alpine3.8 AS alpine
ENV PYTHONUNBUFFERED 1

# Global

RUN apk add --no-cache --update --virtual .global-deps \
    ca-certificates \
    bash

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY . /app/src
WORKDIR /app

EXPOSE 5000

CMD ["gunicorn", "-b", ":5000", "--access-logfile", "-", "--error-logfile", "-", "src.app"]
