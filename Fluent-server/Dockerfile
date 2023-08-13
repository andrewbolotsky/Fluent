FROM  ubuntu:23.10

ADD . /fluent
#added server directory of project
SHELL ["/bin/bash", "-c"]
RUN  export MY_INSTALL_DIR=$HOME/.local && \
          mkdir -p $MY_INSTALL_DIR && \
          export PATH="$MY_INSTALL_DIR/bin:$PATH" && \
    	apt update && \
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
ENTRYPOINT ["/bin/sh", "-c", "bash"]
