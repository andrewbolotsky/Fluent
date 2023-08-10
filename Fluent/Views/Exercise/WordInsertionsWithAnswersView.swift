//
//  WordInsertionsWithAnswersView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 04.08.2023.
//

import SwiftUI


import SwiftUI

fileprivate struct WordInsertionWithAnswerOptionsView: View {
    var descriptionLeft:String
    var descriptionRight:String
    var answerOptions:[String]
    var correctWord:String
    @Binding var exerciseIndex:Int
    @State private var selectedOption: String?
    @State var isSubmitClicked = false
    private func showSubmitButton()->some View{
        Button(action: {
            isSubmitClicked = true
        }) {
            Text("Submit")
                .font(.subheadline)
                .padding()
                .background(
                    !isSubmitClicked || (selectedOption == nil || selectedOption == correctWord) ? Color.accentColor: Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    var body: some View {
        if selectedOption == correctWord && isSubmitClicked{
            showNextButton(exerciseIndex: $exerciseIndex)
        }
        else{
            VStack {
                Text(descriptionLeft+" "+String(repeatElement("_", count: Int.random(in: 1...correctWord.count*2)))+" "+descriptionRight)
                    .font(.title)
                    .padding()
                
                ForEach(answerOptions, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                        isSubmitClicked = false
                    }) {
                        Text(option)
                            .font(.subheadline)
                            .padding()
                            .background(selectedOption == option ? Color.accentColor : Color("VeryLightGray"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
                if let selectedOption = selectedOption {
                    Text("You chosen: \(selectedOption)")
                        .font(.headline)
                        .padding().frame(height: 40)
                }
                else{
                    Spacer().frame(height:40)
                }
                showSubmitButton()
            }
        }
    }
}

extension WordInsertionWithAnswerOptions {
    var body: some View {
        WordInsertionWithAnswerOptionsView(descriptionLeft: descriptionLeft, descriptionRight: descriptionRight, answerOptions: answersOptions, correctWord: correctWord, exerciseIndex: $exerciseIndex)
    }
}

struct WordInsertionsWithAnswersView_Previews: PreviewProvider {
    static var previews: some View {
        WordInsertionWithAnswerOptions(id: UUID().hashValue, complexity: 23, languageFrom: .Russian, languageTo: .English, descriptionLeft: "Who ", descriptionRight: "Mr. James", correctWord: "is", answersOptions: ["are","is","him","what"])
    }
}
