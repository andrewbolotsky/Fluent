//
//  LessonView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 03.08.2023.
//

import SwiftUI

extension Lesson: View {
    var body: some View {
        VStack{
            if course.exercisesIndex < exercises.count{
                VStack{
                    switch exercises[course.exercisesIndex].type{
                    case .WordInsertion:
                        WordInsertion(exercises[course.exercisesIndex] as! WordInsertion, index: $course.exercisesIndex)
                        /*case .Crossword:
                         (exercises[course.exercisesIndex] as! Crossword).onAppear {
                         (exercises[course.exercisesIndex] as! SpeakingExercise).exerciseIndex = $course.exercisesIndex
                         }
                         */case .WordCards:
                        WordCards(exercises[course.exercisesIndex] as! WordCards, index: $course.exercisesIndex)
                        /*
                         case .Speaking:
                         (exercises[course.exercisesIndex] as! SpeakingExercise).onAppear {
                         (exercises[course.exercisesIndex] as! SpeakingExercise).exerciseIndex = $course.exercisesIndex
                         }
                         case .Reading:
                         (exercises[course.exercisesIndex] as! Reading).onAppear {
                         (exercises[course.exercisesIndex] as! Reading).exerciseIndex = $course.exercisesIndex
                         }
                         case .WordInsertionWithAnswerOptions:
                         (exercises[course.exercisesIndex] as! WordInsertionWithAnswerOptions).onAppear {
                         (exercises[course.exercisesIndex] as! WordInsertionWithAnswerOptions).exerciseIndex = $course.exercisesIndex
                         }
                         case .Listening:
                         ComingSoonView()
                         case .Lesson:
                         ComingSoonView()
                         case .VideoLesson:
                         ComingSoonView()*/
                    default:
                        EmptyView().onAppear{
                            print("EmptyView in default")
                        }
                    }
                }
            }
            else{
                if newLesson{
                    Text("hey").onAppear{print()
                        print("12312312312312312312")
                        course.deleteLesson()
                        course.exercisesIndex = 0
                        newLesson = false
                    }
                }
            }
        }
    }
}

struct LessonView_Previews: PreviewProvider {
    static var previews: some View {
        Lesson(name:"First Lesson",complexity: .A1,exercises: [WordCards(id:1231212,complexity: 40,languageFrom: .Russian,languageTo: .English,cards:[WordCards.Card(wordFrom: "лошадь", wordTo: "horse")]),WordInsertion(id: 1, complexity: 123, languageFrom: .Russian, languageTo: .English, descriptionLeft: "Lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e", descriptionRight: "lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e", correctWord: "qwerty")])
    }
}
