//
// Created by Андрей Болоцкий on 15.08.2023.
//

#ifndef FLUENT_SERVER_DATABASE_HPP
#include <memory>
#include <pqxx/pqxx>
#include <vector>
#include "fluent.grpc.pb.h"
using fluent_proto::CourseGeneralInfo;
using fluent_proto::Exercise;
using fluent_proto::ExerciseType;
using fluent_proto::Language;
using fluent_proto::LanguageLevel;

namespace fluent_server {
std::string getConnectionString(const std::string &filepath);
struct InternalExercise {
    int id;
    int complexity;
    int type;
    int language_to;
    int language_from;
    std::string content;
};

class Database {
    pqxx::connection connection;
    std::string shield_string(const std::string &unprotected_string);

public:
    explicit Database(const std::string &connection_string);

    bool signUp(const std::string &email, const std::string &password);
    std::optional<int> logIn(
        const std::string &email,
        const std::string &password,
        int language_from_id,
        int language_to_id
    );
    bool addLanguageToUser(
        const std::string &email,
        const std::string &password,
        int language_level_id,
        int language_from_id,
        int language_to_id
    );
    std::string getLessonName(int course_id, int user_lesson_index);

    int getLessonId(int course_id, int user_lesson_index);
    std::optional<InternalExercise>
    getExercise(int lesson_id, int exercise_index);
    std::vector<CourseGeneralInfo> getUserCourses(
        int course_type,
        int level_id,
        int language_to_id,
        int language_from_id,
        const std::string &email
    );
    CourseGeneralInfo
    changeUserCourseCondition(int course_id, const std::string &email);
    void dropUserIfExist(const std::string& email);
};
}  // namespace fluent_server

#define FLUENT_SERVER_DATABASE_HPP

#endif  // FLUENT_SERVER_DATABASE_HPP
