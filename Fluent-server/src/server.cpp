//
// Created by Андрей Болоцкий on 14.08.2023.
//
#include "server.hpp"

namespace fluent_server {

ServerService::ServerService(Database database)
    : database(std::move(database)) {
}

::grpc::Status ServerService::SignUp(
    ::grpc::ServerContext *context,
    const ::fluent_proto::SignUpData *request,
    ::fluent_proto::IsCorrectQuery *response
) {
    std::unique_lock lock(mutex);
    response->set_is_correct(
        database.signUp(request->username(), request->password())
    );
    lock.unlock();
    return Status::OK;
}

::grpc::Status ServerService::Login(
    ::grpc::ServerContext *context,
    const ::fluent_proto::UserData *request,
    ::fluent_proto::LoginInfo *response
) {
    std::unique_lock lock(mutex);
    auto value = database.logIn(
        request->username(), request->password(), request->language_from(),
        request->language_to()
    );
    lock.unlock();
    if (value == std::nullopt) {
        response->set_login_error(::fluent_proto::Error::ERROR_INCORRECT_LOGIN);
    } else {
        auto username = request->username();
        auto password = request->password();
        UserFullData data;
        data.set_allocated_password(&password);
        data.set_allocated_username(&username);
        data.set_language_from(request->language_from());
        data.set_language_to(request->language_to());
        data.set_level(static_cast<LanguageLevel>(value.value()));
        response->set_allocated_user_data(&data);
    }
    return Status::OK;
}

::grpc::Status ServerService::AddLanguageToUser(
    ::grpc::ServerContext *context,
    const ::fluent_proto::UserFullData *request,
    ::fluent_proto::IsCorrectQuery *response
) {
    std::unique_lock lock(mutex);
    auto value = database.addLanguageToUser(
        request->username(), request->password(), request->level(),
        request->language_from(), request->language_to()
    );
    lock.unlock();
    response->set_is_correct(value);
    return Status::OK;
}

::grpc::Status ServerService::GetCourses(
    ::grpc::ServerContext *context,
    const ::fluent_proto::UserInfoForCourse *request,
    ::fluent_proto::UserCourses *response
) {
    std::unique_lock lock(mutex);
    auto value = database.getUserCourses(
        request->course_type(), request->level(), request->language_to(),
        request->language_from(), request->email()
    );
    lock.unlock();
    for (auto &course : value) {
        CourseGeneralInfo *course_info = response->add_courses();
        *course_info = course;
    }
    return Status::OK;
}

::grpc::Status ServerService::GetLesson(
    ::grpc::ServerContext *context,
    const ::fluent_proto::CourseGeneralInfo *request,
    ::grpc::ServerWriter< ::fluent_proto::Exercise> *writer
) {
    int index = 0;
    std::vector<InternalExercise> exercises;
    std::unique_lock lock(mutex);
    int lesson_id = database.getLessonId(request->id(),request->user_lesson_index());
    std::optional<InternalExercise> value;
    value = database.getExercise(lesson_id, index);
    while (value){

        exercises.push_back(value.value());
        index++;
        value = database.getExercise(lesson_id, index);
    }
    lock.unlock();
    for (auto &value:exercises){
        Exercise exercise;
        exercise.set_id(value.id);
        exercise.set_language_to(static_cast<Language>(value.language_to));
        exercise.set_language_from(static_cast<Language>(value.language_from));
        exercise.set_complexity(value.complexity);
        exercise.set_content(value.content);
        writer->Write(exercise);
    }
    return Status::OK;
}

::grpc::Status ServerService::GetLessonName(
    ::grpc::ServerContext *context,
    const ::fluent_proto::CourseGeneralInfo *request,
    ::fluent_proto::LessonName *response
) {
    std::unique_lock lock(mutex);
    auto value =
        database.getLessonName(request->id(), request->user_lesson_index());
    lock.unlock();
    response->set_name(value);
    return Status::OK;
}

::grpc::Status ServerService::LessonIsDone(
    ::grpc::ServerContext *context,
    const ::fluent_proto::LessonUserInfo *request,
    ::fluent_proto::CourseGeneralInfo *response
) {
    std::unique_lock lock(mutex);
    auto value = database.changeUserCourseCondition(
        request->course_id(), request->email()
    );
    lock.unlock();
    *response = value;
    return Status::OK;
}

void RunServer(const std::string &db_path) {
    std::string server_address("0.0.0.0:50051");
    ServerService service((Database(getConnectionString(db_path))));

    ServerBuilder builder;
    builder.AddListeningPort(server_address, grpc::InsecureServerCredentials());
    builder.RegisterService(&service);
    std::unique_ptr<Server> server(builder.BuildAndStart());
    std::cout << "ServerService listening on " << server_address << std::endl;
    server->Wait();
}
}  // namespace fluent_server