//
//  ReadingExerciseView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 29.07.2023.
//

import SwiftUI

extension Reading.TrueFalseExercise:View{
    private struct BoolButton: View{
        @Binding var result:Bool?
        var text:String
        var body: some View{
            Button{
                if (text=="True"){
                    result = true
                }
                if (text=="False"){
                    result = false
                }
            }label:{
                Text(text)
                    .foregroundColor(.white)
            }.background(Color(.gray)).clipShape(RoundedRectangle.init(cornerRadius: 10)).buttonStyle(.bordered)
            
        }
    }
    var body:some View{
        VStack{
            Text(description).padding(10)
            HStack{
                BoolButton(result: $answer,text:"True")
                BoolButton(result: $answer,text:"False")
            }
            if $answer.wrappedValue != nil {
                CorrectnessLabel(isUserAnswerCorrect: correctAnswer == $answer.wrappedValue)
            }
        }
    }
}

extension Reading{
    var body: some View{
        VStack{
            ScrollView{
                Text(name).bold().font(.title)
                Text(text).padding(10)
                Text("Exercises").bold().font(.title).padding(.top,30)
                ForEach(0..<exercises.count, id: \.self) { index in
                        exercises[index].onSubmit {
                            if exercises[index].$answer.wrappedValue != nil{
                                if exercises[index].correctAnswer == exercises[index].$answer.wrappedValue
                                {
                                    exerciseConditions[index] = true
                                }
                                else{
                                    exerciseConditions[index] = false
                                    
                                }
                            }
                        }
                    }.padding(.bottom,30)
                if !exerciseConditions.isEmpty && exerciseConditions == Array(repeatElement(true, count: exerciseConditions.count)){
                    NextActionButton(isSet: .constant(false))
                }
            }
        }
    }
}




struct ReadingExerciseViews_Previews: PreviewProvider {
    static var previews: some View {
        Reading(id: 1, complexity: 1, languageFrom: LanguageFrom.Russian, languageTo: LanguageTo.English, name: "Lorem Ipsum", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?", exercises: [Reading.TrueFalseExercise(id:12312,description: "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born ", correctAnswer: true),Reading.TrueFalseExercise(id: 1123,description: "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born ", correctAnswer: true)])
        
    }
}

