#include"fluent.grpc.pb.h"

using grpc::Server;
using grpc::ServerBuilder;
using grpc::ServerContext;
using grpc::ServerReader;
using grpc::ServerReaderWriter;
using grpc::ServerWriter;
using grpc::Status;
using fluent_proto::LanguageLevel;
using fluent_proto::Language;
using fluent_proto::LessonInfo;
using fluent_proto::LessonName;
using fluent_proto::ExerciseType;
using fluent_proto::UserGeneralInfo;
using fluent_proto::Exercise;
using fluent_proto::SignUpData;
using fluent_proto::CourseGeneralInfo;
using fluent_proto::UserData;
using fluent_proto::UserFullData;

class ServerImpl final : public fluent_proto::Server::Service{


};
