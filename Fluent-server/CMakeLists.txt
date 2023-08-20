cmake_minimum_required(VERSION 3.8)
include_directories(include)
project(Fluent-server C CXX)
find_package(protobuf CONFIG REQUIRED)
find_package(gRPC CONFIG REQUIRED)
find_package(Threads)

add_subdirectory(/libpqxx build-pqxx)

set(PROTO_FILES
        fluent.proto
        )


add_library(fluent_proto ${PROTO_FILES})
target_link_libraries(fluent_proto
        PUBLIC
        protobuf::libprotobuf
        gRPC::grpc
        gRPC::grpc++
        )
target_include_directories(fluent_proto PUBLIC ${CMAKE_CURRENT_BINARY_DIR})


get_target_property(grpc_cpp_plugin_location gRPC::grpc_cpp_plugin LOCATION)
protobuf_generate(TARGET fluent_proto LANGUAGE cpp)
protobuf_generate(TARGET fluent_proto LANGUAGE grpc GENERATE_EXTENSIONS .grpc.pb.h .grpc.pb.cc PLUGIN "protoc-gen-grpc=${grpc_cpp_plugin_location}")

add_executable(database_tester src/database.cpp src/doctest_main.cpp src/databaseTest.cpp )
target_link_libraries(database_tester  pqxx fluent_proto)
set(SOURCES
        src/main.cpp
        src/server.cpp
        src/database.cpp)

source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${SOURCES})


add_executable(server ${SOURCES})
target_link_libraries(server
        PRIVATE
        fluent_proto pqxx
        )
add_executable(create_tables_in_database src/databaseSetup.cpp)
target_link_libraries(create_tables_in_database PRIVATE pqxx)

