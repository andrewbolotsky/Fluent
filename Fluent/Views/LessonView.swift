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
                        case .Crossword:
                        Crossword( exercises[course.exercisesIndex] as! Crossword,index:$course.exercisesIndex)
                         
                         case .WordCards:
                        WordCards(exercises[course.exercisesIndex] as! WordCards, index: $course.exercisesIndex)
                        
                         case .Speaking:
                         SpeakingExercise(exercises[course.exercisesIndex] as! SpeakingExercise,index: $course.exercisesIndex)
                        /*
                         case .Reading:
                         (exercises[course.exercisesIndex] as! Reading).onAppear {
                         (exercises[course.exercisesIndex] as! Reading).exerciseIndex = $course.exercisesIndex
                         }
                         */
                         case .WordInsertionWithAnswerOptions:
                        WordInsertionWithAnswerOptions(exercises[course.exercisesIndex] as! WordInsertionWithAnswerOptions,index:$course.exercisesIndex)
                         /*
                         case .Listening:
                         ComingSoonView()
                         */
                         case .Learning:
                        Learning(exercises[course.exercisesIndex] as! Learning,index:$course.exercisesIndex)
                        /*
                         case .VideoLesson:
                         ComingSoonView()*/
                    default:
                        EmptyView().onAppear{
                            
                        }
                    }
                }
            }
            else{
                if newLesson{
                    Text("hey").onAppear{
                        
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
