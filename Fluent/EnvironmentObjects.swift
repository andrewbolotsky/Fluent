//
//  EnvironmentObjects.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 04.08.2023.
//

import Foundation
enum Themes{
    case Standard
}
class GlobalStates:ObservableObject{
    @Published var firstName:String
    @Published var secondName:String
    @Published var languageFrom:LanguageFrom
    @Published var languageTo:LanguageTo
    @Published var courses:[Course]
    @Published var theme:Themes = .Standard
    @Published var currentCourseIndex = 0
    @Published var wordCardsCourses:[Course] = Array()
    @Published var wordInsertionCourses:[Course] = Array()
    @Published var speakingCourses:[Course] = Array()
    @Published var readingCourses:[Course] = Array()
    @Published var crosswordCourses:[Course] = Array()
    @Published var listeningCourses:[Course] = Array()
    init(firstName: String, secondName: String, languageFrom: LanguageFrom, languageTo: LanguageTo, courses: [Course], theme: Themes = .Standard, currentCourseIndex: Int = 0, wordCardsCourses: [Course] = Array(), wordInsertionCourses: [Course] = Array(), speakingCourses: [Course] = Array(), readingCourses: [Course] = Array(), crosswordCourses: [Course] = Array(), listeningCourses: [Course] = Array()) {
        self.firstName = firstName
        self.secondName = secondName
        self.languageFrom = languageFrom
        self.languageTo = languageTo
        self.courses = courses
        self.theme = theme
        self.currentCourseIndex = currentCourseIndex
        self.wordCardsCourses = wordCardsCourses
        self.wordInsertionCourses = wordInsertionCourses
        self.speakingCourses = speakingCourses
        self.readingCourses = readingCourses
        self.crosswordCourses = crosswordCourses
        self.listeningCourses = listeningCourses
    }
    
}



