FROM python:3.8-alpine
MAINTAINER Lucas Araujo

ENV PYTHONUNBUFFERED 1

ENV VIRTUAL_ENV=/py
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

COPY ./requirements.txt /requirements.txt
COPY ./app /app

WORKDIR /app

RUN pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client &&\
    apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev &&\
    pip install -r /requirements.txt &&\
    apk del .tmp-build-deps

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]