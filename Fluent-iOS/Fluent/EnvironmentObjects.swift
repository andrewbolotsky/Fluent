//
//  EnvironmentObjects.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 04.08.2023.
//

import Foundation

enum Themes {
    case Standard
}
class GlobalStates: ObservableObject {
    @Published var username: String = ""
    @Published var languageFrom: LanguageFrom = .english
    @Published var languageTo: LanguageTo = .english
    @Published var courses: [Course] = Array()
    @Published var theme: Themes = .Standard
    @Published var password:String = ""
    @Published var level:Int = 0
    @Published var currentCourseIndex = 0
    @Published var wordCardsCourses: [Course] = Array()
    @Published var wordInsertionCourses: [Course] = Array()
    @Published var wordInsertionCoursesWithAnswerOptions: [Course] = Array()
    @Published var speakingCourses: [Course] = Array()
    @Published var readingCourses: [Course] = Array()
    @Published var crosswordCourses: [Course] = Array()
    @Published var listeningCourses: [Course] = Array()
    @Published var client: FluentClient = FluentClient()
    

}
