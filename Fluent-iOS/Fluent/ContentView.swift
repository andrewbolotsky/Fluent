//
//  ContentView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 29.07.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var states: GlobalStates = GlobalStates(
        firstName: "Andrew", secondName: "Bolotsky",
        languageFrom: .Russian, languageTo: .English,
        courses: [
            Course(
                lessons: [
                    Lesson(
                        name: "First Lesson",
                        complexity: .A1,
                        exercises: [
                            WordCards(
                                id: 1_231_212,
                                complexity: 40,
                                languageFrom: .Russian,
                                languageTo: .English,
                                cards: [
                                    WordCards.Card(
                                        wordFrom: "лошадь",
                                        wordTo: "horse"),
                                    WordCards.Card(
                                        wordFrom: "курица",
                                        wordTo: "chicken"),
                                    WordCards.Card(
                                        wordFrom: "мама",
                                        wordTo: "mother"),
                                ]),
                            WordInsertion(
                                id: 1, complexity: 123,
                                languageFrom: .Russian,
                                languageTo: .English,
                                descriptionLeft:
                                    "Lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e",
                                descriptionRight:
                                    "lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e",
                                correctWord: "qwerty"),
                            Crossword(
                                id: 3432, complexity: 12,
                                languageFrom: .Russian,
                                languageTo: .English,
                                exerciseIndex: .constant(0),
                                correctAnswers: Array(
                                    repeating: Array(
                                        repeating: "",
                                        count: 4), count: 4),
                                crossword: [
                                    [
                                        CrosswordCell(
                                            isBlocked:
                                                false,
                                            isGuessed:
                                                false,
                                            hint: "0"),
                                        CrosswordCell(
                                            isBlocked: true,
                                            isGuessed: false
                                        ),
                                        CrosswordCell(
                                            isBlocked:
                                                false,
                                            isGuessed: false
                                        ),
                                        CrosswordCell(
                                            isBlocked:
                                                false,
                                            isGuessed: false
                                        ),
                                    ],

                                    [
                                        CrosswordCell(
                                            isBlocked:
                                                false,
                                            isGuessed: false
                                        ),
                                        CrosswordCell(
                                            isBlocked: true,
                                            isGuessed: false
                                        ),
                                        CrosswordCell(
                                            isBlocked:
                                                false,
                                            isGuessed: false
                                        ),
                                        CrosswordCell(
                                            isBlocked:
                                                false,
                                            isGuessed: false
                                        ),
                                    ],

                                    [
                                        CrosswordCell(
                                            isBlocked:
                                                false,
                                            isGuessed: false
                                        ),
                                        CrosswordCell(
                                            isBlocked:
                                                false,
                                            isGuessed: false
                                        ),
                                        CrosswordCell(
                                            isBlocked:
                                                false,
                                            isGuessed: false
                                        ),
                                        CrosswordCell(
                                            isBlocked: true,
                                            isGuessed: false
                                        ),
                                    ],

                                    [
                                        CrosswordCell(
                                            isBlocked:
                                                false,
                                            isGuessed: false
                                        ),
                                        CrosswordCell(
                                            isBlocked:
                                                false,
                                            isGuessed: false
                                        ),
                                        CrosswordCell(
                                            isBlocked: true,
                                            isGuessed: false
                                        ),
                                        CrosswordCell(
                                            isBlocked:
                                                false,
                                            isGuessed: false
                                        ),
                                    ],
                                ],
                                hints: [
                                    "This is empty word"
                                ]),
                            Learning(
                                id: UUID().hashValue,
                                complexity: 12,
                                languageFrom: .Russian,
                                languageTo: .English,
                                markdownText:
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
                            ),
                            WordInsertionWithAnswerOptions(
                                id: UUID().hashValue,
                                complexity: 23,
                                languageFrom: .Russian,
                                languageTo: .English,
                                descriptionLeft: "Who ",
                                descriptionRight:
                                    "Mr. James",
                                correctWord: "is",
                                answersOptions: [
                                    "are", "is", "him",
                                    "what",
                                ]),
                            SpeakingExercise(
                                id: UUID().hashValue,
                                complexity: 10,
                                languageFrom: .Russian,
                                languageTo: .English,
                                correctAnswer:
                                    "Some people think, but some people don't"
                            ),
                            Reading(
                                id: 1, complexity: 1,
                                languageFrom: LanguageFrom.Russian,
                                languageTo: LanguageTo.English,
                                name: "Lorem Ipsum",
                                text:
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
                                exercises: [
                                    Reading.TrueFalseExercise(
                                        id: 12312,
                                        description:
                                            "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born ",
                                        correctAnswer: true),
                                    Reading.TrueFalseExercise(
                                        id: 1123,
                                        description:
                                            "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born ",
                                        correctAnswer: true),
                                ])
                        ]
                    ),
                    Lesson(
                        name: "Second Lesson",
                        complexity: .A1,
                        exercises: [
                            WordCards(
                                id: 1231, complexity: 40,
                                languageFrom: .Russian,
                                languageTo: .English,
                                cards: [
                                    WordCards.Card(
                                        wordFrom: "лошадь",
                                        wordTo: "horse"),
                                    WordCards.Card(
                                        wordFrom: "курица",
                                        wordTo: "chicken"),
                                    WordCards.Card(
                                        wordFrom: "мама",
                                        wordTo: "mother"),
                                ]),
                            WordInsertion(
                                id: 12_121_231,
                                complexity: 123,
                                languageFrom: .Russian,
                                languageTo: .English,
                                descriptionLeft:
                                    "Lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e",
                                descriptionRight:
                                    "lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e",
                                correctWord: "qwerty"),
                        ]
                    ),
                ], allLessonsCount: 2)
        ],
        wordCardsCourses: [
            Course(
                name: "Plain word cards",
                lessons: [
                    Lesson(
                        name: "First Lesson",
                        complexity: .A1,
                        exercises: [
                            WordCards(
                                id: 1_231_212,
                                complexity: 40,
                                languageFrom: .Russian,
                                languageTo: .English,
                                cards: [
                                    WordCards.Card(
                                        wordFrom: "лошадь",
                                        wordTo: "horse"),
                                    WordCards.Card(
                                        wordFrom: "курица",
                                        wordTo: "chicken"),
                                    WordCards.Card(
                                        wordFrom: "мама",
                                        wordTo: "mother"),
                                ])
                        ]
                    ),
                    Lesson(
                        name: "Second Lesson",
                        complexity: .A1,
                        exercises: [
                            WordCards(
                                id: 1231, complexity: 40,
                                languageFrom: .Russian,
                                languageTo: .English,
                                cards: [
                                    WordCards.Card(
                                        wordFrom: "лошадь",
                                        wordTo: "horse"),
                                    WordCards.Card(
                                        wordFrom: "курица",
                                        wordTo: "chicken"),
                                    WordCards.Card(
                                        wordFrom: "мама",
                                        wordTo: "mother"),
                                ])
                        ]
                    ),
                ], allLessonsCount: 2)
        ])
    var body: some View {
        TabView {
            CourseView().tabItem {
                Image(
                    systemName:
                        "app.connected.to.app.below.fill"
                ).foregroundColor(.accentColor)
                Text("Course")
            }.environmentObject(
                states.courses[states.currentCourseIndex])
            EntertainmentView().tabItem {
                Image(
                    systemName: "arrowtriangle.right.fill"
                ).foregroundColor(.accentColor)
                Text("Entertainment")
            }
            ExercisesView().tabItem {
                Image(systemName: "books.vertical.fill")
                    .foregroundColor(.accentColor)
                Text("Exercises")
            }
            AccountView().tabItem {
                Image(systemName: "person.fill")
                    .foregroundColor(.accentColor)
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
