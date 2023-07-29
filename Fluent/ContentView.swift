//
//  ContentView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 29.07.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var states:GlobalStates = GlobalStates(firstName: "Andrew", secondName: "Bolotsky", languageFrom: .Russian, languageTo: .English, courses:
                                                            [Course(lessons:
                                                            [ Lesson(name:"First Lesson",complexity: .A1,exercises: [WordCards(id:1231212,complexity: 40,languageFrom: .Russian,languageTo: .English,cards:
                                                                                                    [WordCards.Card(wordFrom: "лошадь", wordTo: "horse"),WordCards.Card(wordFrom: "курица", wordTo: "chicken"),WordCards.Card(wordFrom: "мама", wordTo: "mother")]),WordInsertion(id: 1, complexity: 123, languageFrom: .Russian, languageTo: .English, descriptionLeft: "Lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e", descriptionRight: "lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e", correctWord: "qwerty")]
                                                                    )
                                                            ,Lesson(name:"Second Lesson",complexity: .A1,exercises: [WordCards(id:1231,complexity: 40,languageFrom: .Russian,languageTo: .English,cards:
                                                                                                                                [WordCards.Card(wordFrom: "лошадь", wordTo: "horse"),WordCards.Card(wordFrom: "курица", wordTo: "chicken"),WordCards.Card(wordFrom: "мама", wordTo: "mother")]),WordInsertion(id: 12121231, complexity: 123, languageFrom: .Russian, languageTo: .English, descriptionLeft: "Lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e", descriptionRight: "lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e", correctWord: "qwerty")]
                                                                                                )], allLessonsCount: 2)])
    var body: some View {
        TabView{
            CourseView().tabItem{
                Image(systemName: "app.connected.to.app.below.fill").foregroundColor(.accentColor)
                Text("Course")
            }.environmentObject(states.courses[states.currentCourseIndex])
            EntertainmentView().tabItem{
                Image(systemName: "arrowtriangle.right.fill").foregroundColor(.accentColor)
                Text("Entertainment")
            }
            ExercisesView().tabItem{
                Image(systemName: "books.vertical.fill").foregroundColor(.accentColor)
                Text("Exercises")
            }
            AccountView().tabItem{
                Image(systemName: "person.fill").foregroundColor(.accentColor)
                Text("Account")
            }
        }.environmentObject(states)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
