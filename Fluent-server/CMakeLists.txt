
cmake_minimum_required(VERSION 3.8)
include_directories(include)
project(Fluent-server C CXX)
find_package(protobuf CONFIG REQUIRED)
find_package(gRPC CONFIG REQUIRED)
find_package(Threads)

#
# Protobuf/Grpc source files
#
set(PROTO_FILES
        fluent.proto
        )

#
# Add Library target with protobuf sources
#
add_library(fluent_proto ${PROTO_FILES})
target_link_libraries(fluent_proto
        PUBLIC
        protobuf::libprotobuf
        gRPC::grpc
        gRPC::grpc++
        )
target_include_directories(fluent_proto PUBLIC ${CMAKE_CURRENT_BINARY_DIR})

#
# Compile protobuf and grpc files in myproto target to cpp
#
get_target_property(grpc_cpp_plugin_location gRPC::grpc_cpp_plugin LOCATION)
protobuf_generate(TARGET fluent_proto LANGUAGE cpp)
protobuf_generate(TARGET fluent_proto LANGUAGE grpc GENERATE_EXTENSIONS .grpc.pb.h .grpc.pb.cc PLUGIN "protoc-gen-grpc=${grpc_cpp_plugin_location}")

#
# Sources
#
set(SOURCES
        src/main.cpp
        src/server.cpp)

source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${SOURCES})


#
# Target
#
add_executable(server ${SOURCES})
target_link_libraries(server
        PRIVATE
        fluent_proto
        )