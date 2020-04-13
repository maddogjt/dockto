# Intermediate build container.
FROM alpine:3 as build_deps

ARG TARGETPLATFORM
ARG VERSION

RUN apk --no-cache add build-base git
RUN apk --no-cache add cmake
RUN apk --no-cache add libjpeg-turbo-dev
RUN apk --no-cache add linux-headers
RUN [[ "${TARGETPLATFORM:6}" != "arm64" ]] && apk --no-cache add raspberrypi-dev raspberrypi-libs raspberrypi || true

FROM build_deps as build

# Download packages
RUN git clone --depth=1 https://github.com/jacksonliam/mjpg-streamer.git

# Install mjpg-streamer
WORKDIR /mjpg-streamer/mjpg-streamer-experimental
#RUN  mkdir _build && cd _build && cmake ..
RUN LDFLAGS=-Wl,--no-as-needed make 
RUN make install

# Build final image
FROM alpine:3

COPY --from=build /usr/local/bin /usr/local/bin
COPY --from=build /usr/local/share /usr/local/share
COPY --from=build /usr/local/lib /usr/local/lib

RUN apk --no-cache add libjpeg
RUN [[ "${TARGETPLATFORM:6}" != "arm64" ]] && apk --no-cache add raspberrypi-libs || true 

COPY start-mjpg-streamer /usr/local/bin/start-mjpg-streamer

ENV VIDEO_DEVICE /dev/video0
ENV PORT 8080
ENV MJPEG_STREAMER_INPUT input_raspicam.so -x 640 -y 480 -fps 20 -ex night
ENV MJPEG_STREAMER_OUTPUT output_http.so -w /usr/local/share/mjpg-streamer/www -p $PORT

EXPOSE $PORT

CMD ["start-mjpg-streamer"]