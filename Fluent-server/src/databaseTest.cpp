#include "database.hpp"
#define DOCTEST_CONFIG_VOID_CAST_EXPRESSIONS
#include "doctest.h"


using fluent_server::Database;

TEST_CASE("Sign Up && Drop user testing")
{
    Database database(fluent_server::getConnectionString("../database.config"));
    database.dropUserIfExist("myemail@gmail.com");
    CHECK(true == database.signUp("myemail@gmail.com","qwerty"));
    CHECK(false == database.signUp("myemail@gmail.com","qwerty"));
    database.dropUserIfExist("myemail@gmail.com");
    CHECK(true == database.signUp("myemail@gmail.com","qwerty"));
    database.dropUserIfExist("myemail@gmail.com");
}
TEST_CASE("Adding language && Login testing")
{
    Database database(fluent_server::getConnectionString("../database.config"));
    database.dropUserIfExist("myemail@gmail.com");
    CHECK(true == database.signUp("myemail@gmail.com","qwerty"));
    CHECK(true == database.addLanguageToUser("myemail@gmail.com","qwerty",0,0,1));
    CHECK(false == database.addLanguageToUser("myemail@gmail.com","qwerty",0,0,1));
    CHECK(true == database.addLanguageToUser("myemail@gmail.com","qwerty",0,0,3));
    CHECK(false == database.addLanguageToUser("myemail@gmail.com","qwerty",5,0,3));
    CHECK(0 == database.logIn("myemail@gmail.com","qwerty",0,1));
    CHECK(0 == database.logIn("myemail@gmail.com","qwerty",0,3));
    database.dropUserIfExist("myemail@gmail.com");
}

//on database are courses and two lessons for them
/*
INSERT INTO courses (name,lessons_count,type_of_course,
                                         language_level_id,language_to,language_from)
                                         VALUES('First course',2,9,0,0,3);
INSERT INTO lessons (name) VALUES('first');
INSERT INTO lessons (name) VALUES('second');
INSERT INTO courses_lessons_relationship(course_id,lesson_index,lesson_id) VALUES(1,0,1);
INSERT INTO courses_lessons_relationship(course_id,lesson_index,lesson_id) VALUES(1,1,2);
*/
TEST_CASE("Get lesson name && get user id testing"){
    Database database(fluent_server::getConnectionString("../database.config"));
    CHECK(database.getLessonName(1,0)=="first");
    CHECK(database.getLessonName(1,1)=="second");
}

TEST_CASE("Get courses general info && change user course condition"){
    Database database(fluent_server::getConnectionString("../database.config"));
    database.dropUserIfExist("myemail@gmail.com");
    std::vector<CourseGeneralInfo> infos;
    CHECK(true == database.signUp("myemail@gmail.com","qwerty"));
    CHECK(false == database.signUp("myemail@gmail.com","qwerty"));
    database.addLanguageToUser("myemail@gmail.com","qwerty",0,3,0);
    infos = database.getUserCourses(9,0,0,3,"myemail@gmail.com");
    CHECK(infos.size()==1);
    CHECK(infos.at(0).user_lesson_index()==0);
    CHECK(infos.at(0).lessons_count()==2);
    CHECK(infos.at(0).id()==1);
    CHECK(infos.at(0).name()=="First course");
    CHECK(database.logIn("myemail@gmail.com","qwerty",3,0)==0);
    database.changeUserCourseCondition(infos[0].id(),"myemail@gmail.com");
    infos = database.getUserCourses(9,0,0,3,"myemail@gmail.com");
    CHECK(infos.size()==1);
    CHECK(infos.at(0).user_lesson_index()==1);
    CHECK(infos.at(0).lessons_count()==2);
    CHECK(infos.at(0).id()==1);
    CHECK(infos.at(0).name()=="First course");
    CHECK(database.logIn("myemail@gmail.com","qwerty",3,0)==0);
    database.changeUserCourseCondition(infos[0].id(),"myemail@gmail.com");
    infos = database.getUserCourses(9,0,0,3,"myemail@gmail.com");
    CHECK(infos.size()==0);
    CHECK(database.logIn("myemail@gmail.com","qwerty",3,0)==7);
    database.dropUserIfExist("myemail@gmail.com");
}
 
TEST_CASE("Get exercises (get lesson)"){
    Database database(fluent_server::getConnectionString("../database.config"));
    CHECK(true == database.signUp("myemail@gmail.com","qwerty"));
    CHECK(false == database.signUp("myemail@gmail.com","qwerty"));
    database.addLanguageToUser("myemail@gmail.com","qwerty",0,3,0);
    std::vector<CourseGeneralInfo> infos;
    infos = database.getUserCourses(9,0,0,3,"myemail@gmail.com");
    CHECK(infos.size()==1);
    CHECK(infos.at(0).user_lesson_index()==0);
    CHECK(infos.at(0).lessons_count()==2);
    CHECK(infos.at(0).id()==1);
    CHECK(infos.at(0).name()=="First course");
    CHECK(database.logIn("myemail@gmail.com","qwerty",3,0)==0);
    int id = database.getLessonId(infos[0].id(),0);
    int index = 0;
    std::optional<fluent_server::InternalExercise> current_exercise = database.getExercise(id,index);
    CHECK(id == 5);
    while (current_exercise){
        CHECK(current_exercise->id == index+1);
        CHECK(current_exercise->language_to == 3);
        CHECK(current_exercise->language_from == 0);
        CHECK(current_exercise->content == "{\"menu\": {\n"
              "  \"id\": \"file\",\n"
              "  \"value\": \"File\",\n"
              "  \"popup\": {\n"
              "    \"menuitem\": [\n"
              "      {\"value\": \"New\", \"onclick\": \"CreateNewDoc()\"},\n"
              "      {\"value\": \"Open\", \"onclick\": \"OpenDoc()\"},\n"
              "      {\"value\": \"Close\", \"onclick\": \"CloseDoc()\"}\n"
              "    ]\n"
              "  }\n"
              "}}");
        index++;
        current_exercise = database.getExercise(id,index);
    }
    database.dropUserIfExist("myemail@gmail.com");
}