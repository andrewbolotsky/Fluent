FROM  ubuntu:23.10

ADD . /fluent
#added server directory of project
SHELL ["/bin/bash", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y wget gnupg valgrind git

#postgres && libpqxx installation

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc |  apt-key add -

RUN apt -y install postgresql

RUN apt-get install -y libpq-dev postgresql-server-dev-all

RUN cd / && git clone https://github.com/jtv/libpqxx.git

#grpc installation
RUN  export MY_INSTALL_DIR=$HOME/.local && \
          mkdir -p $MY_INSTALL_DIR && \
          export PATH="$MY_INSTALL_DIR/bin:$PATH" && \
        apt install -y build-essential autoconf libtool pkg-config git && \
        git clone --recurse-submodules -b v1.56.0 --depth 1 --shallow-submodules https://github.com/grpc/grpc && \
        cd grpc && \
        mkdir -p cmake/build && \
        pushd cmake/build && \
        apt install -y cmake && \
        cmake -DgRPC_INSTALL=ON       -DgRPC_BUILD_TESTS=OFF       -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR       ../.. && \
        make -j 4 && \
        make install && \
        popd

RUN  cd /grpc && \
            mkdir -p cmake/build && \
            pushd cmake/build && \
            apt install -y cmake && \
            cmake -DgRPC_INSTALL=ON       -DgRPC_BUILD_TESTS=OFF       -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR       ../.. && \
            make -j 4 && \
            make install && \
            popd

RUN apt install -y gdb
