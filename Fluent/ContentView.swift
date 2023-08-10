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
                                                                [WordCards.Card(wordFrom: "лошадь", wordTo: "horse"),WordCards.Card(wordFrom: "курица", wordTo: "chicken"),WordCards.Card(wordFrom: "мама", wordTo: "mother")]),WordInsertion(id: 1, complexity: 123, languageFrom: .Russian, languageTo: .English, descriptionLeft: "Lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e", descriptionRight: "lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e", correctWord: "qwerty"),Crossword(id: 3432, complexity: 12, languageFrom: .Russian, languageTo: .English, exerciseIndex: .constant(0), correctAnswers: Array(repeating: Array(repeating: "", count: 4), count: 4), crossword: [
                                                                    [CrosswordCell(isBlocked: false, isGuessed: false,hint:"0"),
                                                                     CrosswordCell(isBlocked: true, isGuessed: false),
                                                                     CrosswordCell(isBlocked: false, isGuessed: false),
                                                                     CrosswordCell(isBlocked: false, isGuessed: false)],
                                                                    
                                                                    [CrosswordCell(isBlocked: false, isGuessed: false),
                                                                     CrosswordCell(isBlocked: true, isGuessed: false),
                                                                     CrosswordCell(isBlocked: false, isGuessed: false),
                                                                     CrosswordCell(isBlocked: false, isGuessed: false)],
                                                                    
                                                                    [CrosswordCell(isBlocked: false, isGuessed: false),
                                                                     CrosswordCell(isBlocked: false, isGuessed: false),
                                                                     CrosswordCell(isBlocked: false, isGuessed: false),
                                                                     CrosswordCell(isBlocked: true, isGuessed: false)],
                                                                    
                                                                    [CrosswordCell(isBlocked: false, isGuessed: false),
                                                                     CrosswordCell(isBlocked: false, isGuessed: false),
                                                                     CrosswordCell(isBlocked: true, isGuessed: false),
                                                                     CrosswordCell(isBlocked: false, isGuessed: false)]
                                                                ],hints: ["This is empty word"]),Learning(id: UUID().hashValue, complexity: 12, languageFrom: .Russian, languageTo: .English, markdownText:
                                                                                                         """
                                      # Heading 1
                                      ## Heading 2
                                      ### Heading 3
                                      #### Heading 4
                                      ##### Heading 5
                                      ###### Heading 6

                                      # Quote

                                      > An apple a day keeps the doctor away.

                                      >> Quote can also be nested,
                                      > > > and spaces are allowed bewteen arrows.

                                      # List

                                      * Unorder list

                                        - apple
                                        + banana
                                        * strawberry

                                      * Order list

                                        1. eat
                                        2. code!
                                        3. sleep

                                        You can also specify the offset:
                                        
                                        11. eat
                                        2. code!
                                        3. sleep

                                      # Code

                                      Supports indent code:

                                          var name = "Talaxy"

                                      and code block syntax:

                                      ```swift
                                      // example
                                      struct Demo: View {
                                          var body: some View {
                                              Text("Hello world!")
                                          }
                                      }
                                      ```

                                      # Border

                                      ---
                                      * * *
                                      __ ___ ____

                                      # Table

                                      Alignment syntax is supported.

                                      | Property | Type   | Description            |
                                      |:-------- |:------:| ----------------------:|
                                      | title    | String | The title of the news. |
                                      | date     | Date   | The date of the news.  |
                                      | author   | String | The author ...         |

                                      """
                                                                                                         ), WordInsertionWithAnswerOptions(id: UUID().hashValue, complexity: 23, languageFrom: .Russian, languageTo: .English, descriptionLeft: "Who ", descriptionRight: "Mr. James", correctWord: "is", answersOptions: ["are","is","him","what"]),SpeakingExercise(id: UUID().hashValue, complexity: 10, languageFrom: .Russian, languageTo: .English,correctAnswer: "Some people think, but some people don't")]
                                                                    )
                                                            ,Lesson(name:"Second Lesson",complexity: .A1,exercises: [WordCards(id:1231,complexity: 40,languageFrom: .Russian,languageTo: .English,cards:
                                                                                                                                [WordCards.Card(wordFrom: "лошадь", wordTo: "horse"),WordCards.Card(wordFrom: "курица", wordTo: "chicken"),WordCards.Card(wordFrom: "мама", wordTo: "mother")]),WordInsertion(id: 12121231, complexity: 123, languageFrom: .Russian, languageTo: .English, descriptionLeft: "Lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e", descriptionRight: "lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e", correctWord: "qwerty")]
                                                                   )], allLessonsCount: 2)],wordCardsCourses: [Course(name:"Plain word cards",lessons:
                                                                                                                                                    [ Lesson(name:"First Lesson",complexity: .A1,exercises: [WordCards(id:1231212,complexity: 40,languageFrom: .Russian,languageTo: .English,cards:
                                                                                                                                                        [WordCards.Card(wordFrom: "лошадь", wordTo: "horse"),WordCards.Card(wordFrom: "курица", wordTo: "chicken"),WordCards.Card(wordFrom: "мама", wordTo: "mother")])]
                                                                                                                                                            )
                                                                                                                                                    ,Lesson(name:"Second Lesson",complexity: .A1,exercises: [WordCards(id:1231,complexity: 40,languageFrom: .Russian,languageTo: .English,cards:
                                                                                                                                                                                                                        [WordCards.Card(wordFrom: "лошадь", wordTo: "horse"),WordCards.Card(wordFrom: "курица", wordTo: "chicken"),WordCards.Card(wordFrom: "мама", wordTo: "mother")])]
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
