FROM python:3-alpine

RUN apk --update-cache add ffmpeg

ARG VERSION

RUN apk add --virtual build-deps gcc musl-dev linux-headers \
    && pip3 install "octoprint==$VERSION" \
    && apk del build-deps

#Create an octoprint user
RUN adduser -D octoprint && adduser octoprint dialout
RUN mkdir /config && chown octoprint:octoprint /config
RUN mkdir /defaults && chown octoprint:octoprint /defaults

#RUN ln -s /data /home/octoprint/.octoprint
COPY config.yaml /defaults/config.yaml
COPY start.sh /home/octoprint/
RUN chown -R octoprint:octoprint /home/octoprint/
RUN chown -R octoprint:octoprint /defaults/
WORKDIR /home/octoprint
USER octoprint
RUN chmod +x /home/octoprint/start.sh

EXPOSE 5000
VOLUME /config

CMD [ "/home/octoprint/start.sh" ]
