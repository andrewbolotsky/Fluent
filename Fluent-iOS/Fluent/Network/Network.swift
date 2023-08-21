//
//  Network.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 20.08.2023.
//

import Foundation
import GRPC
import NIO
import SwiftProtobuf
typealias Language=FluentProto_Language
final class FluentClient {
    var port:Int
    var fluentClient: FluentProto_ServerNIOClient?
    init(port: Int = 42329) {
        self.port = port
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        do {
        // open a channel to the gPRC server
            let channel = try GRPCChannelPool.with(
        target: .host("localhost", port: self.port), transportSecurity: .plaintext, eventLoopGroup: eventLoopGroup
        )
            self.fluentClient =
            FluentProto_ServerNIOClient(channel: channel)
            print("grpc connection initialized")
        } catch {
        print("Couldn’t connect to gRPC server")
        }
    }
    func signUp(username:String,password:String)->Bool{
        let signUpData = FluentProto_SignUpData.with{
            $0.username = username
            $0.password = password
        }
        let call = self.fluentClient!.signUp(signUpData)
        let result:FluentProto_IsCorrectQuery
        do{
            result = try call.response.wait()
        }
        catch {
            print("RPC method ‘sign up’ failed: \(error)")
            return false
        }
        return result.isCorrect
        }
    
    func logIn(username:String,password:String,languageFrom:Language,languageTo:Language)->Int?{
        let logInData = FluentProto_UserData.with{
            $0.username = username
            $0.password = password
            $0.languageTo = languageTo
            $0.languageFrom = languageFrom
        }
        let call = self.fluentClient!.login(logInData)
        let result:FluentProto_LoginInfo
        do{
            result = try call.response.wait()
        }
        catch {
            print("RPC method ‘log in’ failed: \(error)")
            return nil
        }
        
        if let data = result.data {
            switch data {
            case .userData(let userData):
                return userData.level.rawValue;
            case .loginError( _):
                return nil;
            }
        }
        return nil;
        
    }
    
    func addLanguageToUser(username:String,password:String,level:Int,languageFrom:Language,languageTo:Language)->Bool{
        let userData = FluentProto_UserFullData.with{
            $0.username = username
            $0.password = password
            $0.level = FluentProto_LanguageLevel(rawValue: level) ?? .a1
            $0.languageTo = languageTo
            $0.languageFrom = languageFrom
        }
        let call = self.fluentClient!.addLanguageToUser(userData)
        let result:FluentProto_IsCorrectQuery
        do{
            result = try call.response.wait()
        }
        catch {
            print("RPC method ‘add language to user’ failed: \(error)")
            return false
        }
        return result.isCorrect
    }
    
    func getLessonName(courseId:Int,courseName:String,lessonsCount:Int,userLessonIndex:Int)->String{
        let generalInfo = FluentProto_CourseGeneralInfo.with{
            $0.id = Int32(courseId)
            $0.name = courseName
            $0.lessonsCount = UInt32(lessonsCount)
            $0.userLessonIndex = UInt32(userLessonIndex)
        }
        let call = self.fluentClient!.getLessonName(generalInfo)
        let result:FluentProto_LessonName
        do{
            result = try call.response.wait()
        }
        catch {
            print("RPC method ‘getLessonName’ failed: \(error)")
            return ""
        }
        return result.name
    }
    func lessonIsDone(courseId:Int,email:String)->FluentProto_CourseGeneralInfo{
        let lessonUserInfo = FluentProto_LessonUserInfo.with{
            $0.courseID = Int32(courseId)
            $0.email = email
        }
        let call = self.fluentClient!.lessonIsDone(lessonUserInfo)
        let result:FluentProto_CourseGeneralInfo
        do{
            result = try call.response.wait()
        }
        catch {
            print("RPC method ‘lessonIsDone’ failed: \(error)")
            return FluentProto_CourseGeneralInfo()
        }
        return result;
    }
    func getCourses(courseType:FluentProto_ExerciseType,level:Int,languageFrom:Language,languageTo:Language,email:String)->[Course] {
        let userInfo = FluentProto_UserInfoForCourse.with{
            $0.courseType = courseType
            $0.level = FluentProto_LanguageLevel(rawValue: level) ?? .a1
            $0.languageTo = languageTo
            $0.languageFrom = languageFrom
            $0.email = email
        }
        let call = self.fluentClient!.getCourses(userInfo)
        let result:FluentProto_UserCourses
        do{
            result = try call.response.wait()
        }
        catch {
            print("RPC method ‘getCourses’ failed: \(error)")
            return []
        }
        var user_courses:[Course] = []
        for course in result.courses{
            var current_course = Course(id:Int(course.id),name: course.name, allLessonsCount: Int(course.lessonsCount), userLessonIndex: Int(course.userLessonIndex))
            user_courses.append(current_course)
        }
        return user_courses
    }
    func getLesson(course:Course){
        let courseInfo = FluentProto_CourseGeneralInfo.with{
            $0.id = Int32(course.id)
            $0.name = course.name
            $0.lessonsCount = UInt32(course.allLessonsCount)
            $0.userLessonIndex = UInt32(course.userLessonIndex)
        }
        var result:[FluentProto_Exercise] = []
        do{
            var streaming = true;
            let stream =  self.fluentClient!.getLesson(courseInfo, handler: { exercise in
                result.append(exercise)
            })
        }
        catch {
            print("RPC method ‘getCourses’ failed: \(error)")
        }
    }
    
    
    
    
}
