//
//  WordInsertionExerciseView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 30.07.2023.
//

import Foundation
import SwiftUI
import Combine

extension WordInsertion{
    func textExercise()->some View{
        return HStack{
            Spacer()
            Spacer()
            Spacer()
            Text(descriptionLeft+" "+String(repeatElement("_", count: correctWord.count))+" "+descriptionRight)
                .multilineTextAlignment(.leading)
            Spacer()
            Spacer()
            Spacer()


        }.frame(height: 150).multilineTextAlignment(.leading)
    }
    func wordEntering()->some View{
        return HStack{
            Spacer()
            Spacer()
            Spacer()
            Text("Enter missing word:")
            TextField("",text:$insertedWord).lineLimit(1).foregroundColor(.accentColor).padding()
                .border(Color.accentColor).onReceive(Just($insertedWord)){
                    _ in formatText(correctWord.count)
                }
            Spacer()
            Spacer()
            Spacer()
        }
    }
    func bottomView()->some View{
            
                VStack{
                    Button{
                        isSubmitted = true
                    }label:{
                        Text("Submit")
                            .foregroundColor(Color("AccentColor")).font(.title)
                    }.frame(width:400).background(Color("LightGray")).clipShape(RoundedRectangle.init(cornerRadius: 10)).buttonStyle(.bordered).shadow(radius: 30).padding()
                    if isSubmitted != nil && isSubmitted! {
                        CorrectnessLabel(isUserAnswerCorrect: $insertedWord.wrappedValue == correctWord)
                    }
                }
    }
    func formatText(_ upper: Int) {
        insertedWord = insertedWord.filter(\.isLetter)
        insertedWord = insertedWord.lowercased()
        if insertedWord.count >= upper {
            insertedWord = String(insertedWord.prefix(upper))
        }
    }
    var body: some View{
        VStack{
            if isSubmitted != nil && isSubmitted! && $insertedWord.wrappedValue  == correctWord{
                showNextButton(exerciseIndex: $exerciseIndex)
            }
            else{
                Spacer()
                HStack{
                    Spacer()
                    VStack{
                        self.textExercise()
                        self.wordEntering().padding(.bottom)
                    }.background(Color("VeryLightGray")).clipShape(RoundedRectangle(cornerRadius: 10)).shadow(radius: 30)
                    Spacer()
                    
                }
                self.bottomView()
                Spacer()
            }
        }
    }
}
struct WordInsertionExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        WordInsertion(id: 1, complexity: 123, languageFrom: .Russian, languageTo: .English, descriptionLeft: "Lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e", descriptionRight: "lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e", correctWord: "qwerty")
    }
}
