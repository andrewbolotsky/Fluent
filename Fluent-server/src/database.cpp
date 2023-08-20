//
// Created by Андрей Болоцкий on 15.08.2023.
//
#include "database.hpp"
#include <fstream>
#include <string>

namespace fluent_server {
std::string getConnectionString(const std::string &filepath) {
    std::ifstream input(filepath);
    std::string connection_string;
    std::getline(input, connection_string);
    return connection_string;
}

std::string Database::shield_string(const std::string &unprotected_string) {
    return connection.esc(unprotected_string);
}

Database::Database(const std::string &connection_string)
    : connection(connection_string.c_str()) {
}

std::optional<int> Database::logIn(
    const std::string &email,
    const std::string &password,
    int language_from_id,
    int language_to_id
) {
    try {
        pqxx::work worker(connection);
        int user_id;
        int language_level_id;
        user_id = worker.query_value<int>(
            "SELECT id from users where email='" + shield_string(email) +
            "' AND password='" + shield_string(password) + "';"
        );
        language_level_id = worker.query_value<int>(
            "SELECT language_level_id from users_languages_relationship where "
            "user_id=" +
            std::to_string(user_id) +
            " AND language_from_id=" + std::to_string(language_from_id) +
            " AND language_to_id=" + std::to_string(language_to_id) + " ;"
        );
        worker.commit();
        return language_level_id;
    } catch (pqxx::unexpected_rows &e) {
        return std::nullopt;
    } catch (pqxx::usage_error &e) {
        return std::nullopt;
    }
}

bool Database::signUp(const std::string &email, const std::string &password) {
    pqxx::work worker(connection);
    try {
        worker.exec0(
            "SELECT id from users where email='" + shield_string(email) +
            "' AND password='" + shield_string(password) + "';"
        );
        worker.exec(
            "INSERT INTO users (email,password) VALUES ('" +
            shield_string(email) + "','" + shield_string(password) + "');"
        );
        worker.commit();
        return true;
    } catch (pqxx::unexpected_rows &) {
        return false;
    }
}

bool Database::addLanguageToUser(
    const std::string &email,
    const std::string &password,
    int language_level_id,
    int language_from_id,
    int language_to_id
) {
    pqxx::work worker(connection);
    try {
        int user_id;
        user_id = worker.query_value<int>(
            "SELECT id from users where email='" + shield_string(email) +
            "' AND password='" + shield_string(password) + "';"
        );
        worker.exec0(
            "SELECT language_level_id from users_languages_relationship where "
            "user_id=" +
            std::to_string(user_id) +
            " AND language_from_id=" + std::to_string(language_from_id) +
            " AND language_to_id=" + std::to_string(language_to_id) + " ;"
        );
        worker.exec(
            "INSERT INTO users_languages_relationship "
            "(user_id,language_from_id,language_to_id,language_level_id) "
            "VALUES ('" +
            std::to_string(user_id) + "','" + std::to_string(language_from_id) +
            "','" + std::to_string(language_to_id) + "','" +
            std::to_string(language_level_id) + "');"
        );
        worker.commit();
        return true;
    } catch (pqxx::unexpected_rows &) {
        return false;
    }
}

std::string Database::getLessonName(int course_id, int user_lesson_index) {
    pqxx::work worker(connection);
    std::string result;
    result = worker.query_value<std::string>(
        "SELECT name FROM lessons WHERE id=(SELECT lesson_id FROM "
        "courses_lessons_relationship WHERE course_id =" +
        std::to_string(course_id) +
        " AND lesson_index =" + std::to_string(user_lesson_index) + ");"
    );
    worker.commit();
    return result;
}

int Database::getLessonId(int course_id, int user_lesson_index) {
    pqxx::work worker(connection);
    int lesson_id;
    lesson_id = worker.query_value<int>(
        "SELECT lesson_id FROM courses_lessons_relationship WHERE course_id=" +
        std::to_string(course_id) +
        " AND lesson_index=" + std::to_string(user_lesson_index) + " ;"
    );
    worker.commit();
    return lesson_id;
}

std::optional<InternalExercise>
Database::getExercise(int lesson_id, int exercise_index) {
    try {
        pqxx::work worker(connection);
        int exercise_id;
        exercise_id = worker.query_value<int>(
            "SELECT exercise_id FROM lessons_exercises_relationship where "
            "lesson_id=" +
            std::to_string(lesson_id) +
            " AND exercise_index= " + std::to_string(exercise_index) + " ;"
        );
        InternalExercise exercise;
        exercise.id = exercise_id;
        exercise.type = worker.query_value<int>(
            "SELECT exercise_type_id WHERE id=" + std::to_string(exercise_id) +
            " ;"
        );
        exercise.complexity = worker.query_value<int>(
            "SELECT complexity WHERE id=" + std::to_string(exercise_id) + " ;"
        );
        exercise.language_from = worker.query_value<int>(
            "SELECT language_from_id WHERE id=" + std::to_string(exercise_id) +
            " ;"
        );
        exercise.language_to = worker.query_value<int>(
            "SELECT language_to_id WHERE id=" + std::to_string(exercise_id) +
            " ;"
        );
        exercise.content = worker.query_value<std::string>(
            "SELECT content WHERE id=" + std::to_string(exercise_id) + " ;"
        );
        worker.commit();
        return exercise;
    } catch (std::exception &) {
        return std::nullopt;
    }
}

std::vector<CourseGeneralInfo> Database::getUserCourses(
    int course_type,
    int level_id,
    int language_to_id,
    int language_from_id,
    const std::string &email
) {
    std::vector<CourseGeneralInfo> courses;
    pqxx::work worker(connection);
    bool flag = true;
    int user_id = worker.query_value<int>(
        "SELECT id FROM users WHERE email='" + shield_string(email) + "';"
    );
    for (auto [id, name, lessons_count] : worker.query<int, std::string, int>(
             "SELECT id, name,lessons_count FROM courses WHERE "
             "type_of_course=" +
             std::to_string(course_type) +
             " AND language_level_id=" + std::to_string(level_id) +
             " AND language_to=" + std::to_string(language_to_id) +
             " AND language_from=" + std::to_string(language_from_id) + " ;"
         )) {
        int user_lesson_index = 0;
        try {
            user_lesson_index = worker.query_value<int>(
                "SELECT user_lesson_index FROM users_courses_relationship "
                "WHERE user_id=" +
                std::to_string(user_id) +
                " AND course_id = " + std::to_string(id) + " ;"
            );
        } catch (std::exception &) {
            worker.exec(
                "INSERT INTO "
                "users_courses_relationship(user_id,course_id,user_lesson_"
                "index) VALUES(" +
                std::to_string(user_id) + "," + std::to_string(id) + ",0)"
            );
        }
        CourseGeneralInfo info;
        info.set_id(id);
        info.set_name(name);
        info.set_lessons_count(lessons_count);
        info.set_user_lesson_index(user_lesson_index);
        courses.push_back(info);
        if (user_lesson_index < lessons_count) {
            flag = false;
        }
    }
    if (flag && level_id < 7) {
        worker.exec(
            "UPDATE users_languages_relationship SET language_level_id= " +
            std::to_string(level_id + 1) +
            " WHERE user_id= " + std::to_string(user_id) +
            " AND language_from_id= " + std::to_string(language_from_id) +
            " AND language_to_id= " + std::to_string(language_to_id) + " ;"
        );
        worker.commit();
        return getUserCourses(
            course_type, level_id + 1, language_to_id, language_from_id, email
        );
    }
    worker.commit();
    return courses;
}

CourseGeneralInfo
Database::changeUserCourseCondition(int course_id, const std::string &email) {
    CourseGeneralInfo course;
    pqxx::work worker{connection};
    int user_id = worker.query_value<int>(
        "SELECT id FROM users WHERE email='" + shield_string(email) + "';"
    );
    int user_lesson_index = worker.query_value<int>(
        "SELECT user_lesson_index FROM users_courses_relationship "
        "WHERE user_id= " +
        std::to_string(user_id) +
        " AND course_id = " + std::to_string(course_id) + " ;"
    );
    int course_lessons_count = worker.query_value<int>(
        "SELECT lessons_count FROM courses WHERE id= " +
        std::to_string(course_id) + " ;"
    );
    if (user_lesson_index + 1 <= course_lessons_count) {
        worker.exec(
            "UPDATE users_courses_relationship SET user_lesson_index=" +
            std::to_string(user_lesson_index + 1) +
            " WHERE course_id=" + std::to_string(course_id) +
            " AND user_id=" + std::to_string(user_id) + " ;"
        );
    }
    CourseGeneralInfo info;
    auto name = worker.query_value<std::string>(
        "SELECT name from courses where id=" + std::to_string(course_id) + ";"
    );
    worker.commit();
    info.set_id(course_id);
    info.set_name(name);
    info.set_lessons_count(course_lessons_count);
    info.set_user_lesson_index(user_lesson_index + 1);
    return info;
}

void Database::dropUserIfExist(const std::string &email) {
    pqxx::work worker{connection};
    try {
        int user_id = worker.query_value<int>(
            "SELECT id FROM users where email='" + shield_string(email) + "';"
        );
        worker.exec(
            "DELETE FROM users_courses_relationship where user_id=" +
            std::to_string(user_id) + ";"
        );
        worker.exec(
            "DELETE FROM users_languages_relationship where user_id=" +
            std::to_string(user_id) + ";"
        );
        worker.exec("DELETE FROM users where email='" + email + "';");
    } catch (std::exception &e) {
    }
    worker.commit();
}

}  // namespace fluent_server