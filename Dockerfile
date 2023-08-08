# build numpy and store it's wheel
ARG WHEELS=/wheels

FROM python:3.11-bullseye as builder
ARG WHEELS
ENV PYTHONUNBUFFERED=1
ENV LC_ALL C
ENV LANG C
ENV LANGUAGE C

RUN apt-get update && \
    apt-get install -y \
	build-essential
RUN python -m pip install -U pip wheel && \
    pip wheel --no-cache-dir -w ${WHEELS} numpy

FROM scratch
ARG WHEELS
COPY --from=builder ${WHEELS} ${WHEELS}
