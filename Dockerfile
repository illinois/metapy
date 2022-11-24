FROM josecols/meta:3.0.2

ENV LD_PRELOAD=/usr/lib/aarch64-linux-gnu/libjemalloc.so.2

COPY . /metapy

RUN apt-get update && apt-get install -y \
    python-is-python3 \
    python3-dev \
    python3-pip

WORKDIR /metapy
RUN git submodule update --init --recursive
RUN mkdir build

WORKDIR /metapy
RUN sed -i 's:add_subdirectory(deps/meta EXCLUDE_FROM_ALL):find_package(MeTA 3.0.2 REQUIRED):g' CMakeLists.txt
RUN pip install .

WORKDIR /app