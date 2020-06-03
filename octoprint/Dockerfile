FROM python:3-alpine

RUN apk --update-cache add ffmpeg py3-numpy

ARG VERSION

ENV PYTHONPATH=/usr/lib/python3.8/site-packages

RUN apk add --virtual build-deps gcc musl-dev linux-headers \
    && pip3 install "octoprint==$VERSION" \
    && apk del build-deps

RUN mkdir /config
RUN mkdir /defaults
RUN mkdir /root/.local

#RUN ln -s /data /home/octoprint/.octoprint
COPY config.yaml /defaults/config.yaml
COPY start_octoprint.sh /usr/local/bin/start_octoprint.sh
RUN chmod +x /usr/local/bin/start_octoprint.sh

EXPOSE 5000
VOLUME /config
VOLUME /root/.local

CMD [ "/usr/local/bin/start_octoprint.sh" ]
