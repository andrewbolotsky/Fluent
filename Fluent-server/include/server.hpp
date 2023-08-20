//
// Created by Андрей Болоцкий on 11.08.2023.
//

#ifndef FLUENT_SERVER_HPP
#include <grpcpp/server_builder.h>
#include "database.hpp"
#include "fluent.grpc.pb.h"
using grpc::Server;
using grpc::ServerBuilder;
using grpc::ServerContext;
using grpc::ServerReader;
using grpc::ServerReaderWriter;
using grpc::ServerWriter;
using grpc::Status;
using fluent_proto::LanguageLevel;
using fluent_proto::Language;
using fluent_proto::LessonUserInfo;
using fluent_proto::LessonName;
using fluent_proto::ExerciseType;
using fluent_proto::UserInfoForCourse;
using fluent_proto::Exercise;
using fluent_proto::SignUpData;
using fluent_proto::CourseGeneralInfo;
using fluent_proto::UserData;
using fluent_proto::UserFullData;
namespace fluent_server{
class ServerService final : public fluent_proto::Server::Service{
    Database database;
    std::mutex mutex;
public:
    explicit ServerService(Database database);
    ::grpc::Status SignUp(::grpc::ServerContext* context, const ::fluent_proto::SignUpData* request, ::fluent_proto::IsCorrectQuery* response) override;
    // returns true if user is signed up, else false
    ::grpc::Status Login(::grpc::ServerContext* context, const ::fluent_proto::UserData* request, ::fluent_proto::LoginInfo* response) override;
    ::grpc::Status AddLanguageToUser(::grpc::ServerContext* context, const ::fluent_proto::UserFullData* request, ::fluent_proto::IsCorrectQuery* response) override;
    ::grpc::Status GetCourses(::grpc::ServerContext* context, const ::fluent_proto::UserInfoForCourse* request, ::fluent_proto::UserCourses* response) override;
    ::grpc::Status GetLesson(::grpc::ServerContext* context, const ::fluent_proto::CourseGeneralInfo* request, ::grpc::ServerWriter< ::fluent_proto::Exercise>* writer) override;
    ::grpc::Status GetLessonName(::grpc::ServerContext* context, const ::fluent_proto::CourseGeneralInfo* request, ::fluent_proto::LessonName* response) override;
    // returns lesson name
    ::grpc::Status LessonIsDone(::grpc::ServerContext* context, const ::fluent_proto::LessonUserInfo* request, ::fluent_proto::CourseGeneralInfo* response) override;
};
void RunServer(const std::string& db_path);
}
#define FLUENT_SERVER_HPP

#endif //FLUENT_SERVER_HPP
