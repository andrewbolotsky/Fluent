//
//  ReadingExerciseView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 29.07.2023.
//

import SwiftUI


fileprivate struct ReadingView: View {
    func correctnessLabel(isUserAnswerCorrect:Bool)->some View {
        VStack{
            if isUserAnswerCorrect {
                Label(
                    "You are absolutely right",
                    systemImage: "checkmark"
                )
                .foregroundColor(.green)
            } else {
                Label("You are not right", systemImage: "xmark")
                    .foregroundColor(.red)
            }
        }
    }
    @State var isSubmitted: Bool? = nil
    var name: String
    var text: String
    var exercises: [Reading.TrueFalseExercise]
    @State private var exerciseConditions: [Bool?] = Array()
    @Binding var exerciseIndex:Int
    @State private var exerciseResults:[Bool]
    init(name: String, text: String, exercises: [Reading.TrueFalseExercise], exerciseIndex: Binding<Int>) {
        self.name = name
        self.text = text
        self.exercises = exercises
        self.exerciseConditions = Array(repeating: nil, count: exercises.count)
        self._exerciseIndex = exerciseIndex
        self.exerciseResults = Array(repeating: false, count: exercises.count)
    }
    func boolButton(index:Int,text:String)->some View{
        Button {
            if text == "True" {
                exerciseConditions[index] = true
                exerciseResults[index] = (exercises[index].correctAnswer
                                          == exerciseConditions[index])
            }
            if text == "False" {
                exerciseConditions[index] = false
                exerciseResults[index] = (exercises[index].correctAnswer
                                          == exerciseConditions[index])
            }
        } label: {
            Text(text)
                .foregroundColor(.white)
        }.background(Color(.gray)).clipShape(
            RoundedRectangle.init(cornerRadius: 10)
        )
        .buttonStyle(
            .bordered)

    }
    func showTrueFalseExercise(index:Int)->some View{
        VStack {
            Text(exercises[index].description).padding(10)
            HStack {
                boolButton(index: index, text: "True")
                boolButton(index: index, text: "False")
            }
            if $exerciseConditions[index].wrappedValue != nil {
                
                correctnessLabel(
                    isUserAnswerCorrect: exercises[index].correctAnswer
                    == exerciseConditions[index])
            }
        }
    }
    
    var body: some View {
        if exerciseResults == Array(repeatElement(true,count: exerciseConditions.count))
        {
            showNextButton(exerciseIndex: $exerciseIndex)
        }
        else{
        VStack {
            ScrollView {
                Text(name).bold().font(.title)
                Text(text).padding(10)
                Text("Exercises").bold().font(.title)
                    .padding(.top, 30)
                ForEach(0..<exercises.count, id: \.self) {
                    index in
                    showTrueFalseExercise(index: index)
                }.padding(.bottom, 30)
                
                }
            }
        }
    }
}
extension Reading: View {
    var body: some View {
        ReadingView(name: name, text: text, exercises: exercises,exerciseIndex: $exerciseIndex)
    }
}
struct ReadingExerciseViews_Previews: PreviewProvider {
    static var previews: some View {
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

    }
}
