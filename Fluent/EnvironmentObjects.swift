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
    init(firstName: String, secondName: String, languageFrom: LanguageFrom, languageTo: LanguageTo, courses: [Course]) {
        self.firstName = firstName
        self.secondName = secondName
        self.languageFrom = languageFrom
        self.languageTo = languageTo
        self.courses = courses
        self.theme = theme
    }
}



