FROM adiibanez/arm7-py3-runtime
ENV UDEV=on
ENV PA_ALSA_PLUGHW=1
# https://forums.balena.io/t/bluetooth-and-pulseaudio-on-rpi3/4353/3
ENV DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket
ENV REDIS_HOST=redis
RUN apt update \
  && apt upgrade -y \
  && apt install -y \
  libopenjp2-7 libtiff5 libjpeg62-turbo \
  python3-gpiozero python3-rpi.gpio \
  libatlas-base-dev libportaudio0 libportaudio2 libportaudiocpp0 portaudio19-dev python3-pyaudio \
  vim ssh \
  && rm -rf /var/lib/apt/lists/*
COPY requirements.txt ./

RUN pip3 install https://dl.google.com/coral/python/tflite_runtime-2.1.0.post1-cp37-cp37m-linux_armv7l.whl
RUN pip3 install https://github.com/lhelontra/tensorflow-on-arm/releases/download/v2.0.0/tensorflow-2.0.0-cp37-none-linux_armv7l.whl
RUN pip3 install -r requirements.txt 

# workaround https://github.com/numpy/numpy/issues/11110
RUN /usr/bin/yes | pip3 uninstall numpy
RUN apt update && apt install python3-numpy && rm -rf /var/lib/apt/lists/*

RUN uname -m
RUN pip3 list