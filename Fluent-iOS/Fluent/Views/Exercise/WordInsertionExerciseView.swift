//
//  WordInsertionExerciseView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 30.07.2023.
//

import Combine
import Foundation
import SwiftUI

extension WordInsertion {
    func textExercise() -> some View {
        return HStack {
            Spacer()
            Spacer()
            Spacer()
            Text(
                descriptionLeft + " "
                    + String(
                        repeatElement(
                            "_", count: correctWord.count))
                    + " "
                    + descriptionRight
            ).font(.title)
                .multilineTextAlignment(.leading)
            Spacer()
            Spacer()
            Spacer()

        }
    }
    func wordEntering() -> some View {
        return HStack {
            Spacer()
            Spacer()
            Spacer()
            Text("Word:").font(.title).bold()
            TextField("", text: $insertedWord).lineLimit(1)
                .foregroundColor(.white).padding()
                .border(Color.accentColor).background(
                    Color.accentColor
                ).font(.title)
                .padding().multilineTextAlignment(.center)
                .cornerRadius(10).onReceive(
                    Just($insertedWord)
                ) {
                    _ in formatText(correctWord.count)
                }
            Spacer()
            Spacer()
            Spacer()
        }
    }
    func bottomView() -> some View {

        VStack {
            Button(action: {
                isSubmitted = true
            }) {
                Text("Submit")
                    .font(.subheadline)
                    .padding()
                    .background(
                        isSubmitted == false
                            || insertedWord == ""
                            || insertedWord == correctWord
                            ? Color.accentColor : Color.red
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
    func formatText(_ upper: Int) {
        insertedWord = insertedWord.filter(\.isLetter)
        insertedWord = insertedWord.lowercased()
        if insertedWord.count >= upper {
            insertedWord = String(
                insertedWord.prefix(upper))
        }
    }
    var body: some View {
        VStack {
            if isSubmitted == true
                && insertedWord == correctWord
            {
                showNextButton(
                    exerciseIndex: $exerciseIndex)
            } else {
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        self.textExercise()
                        self.wordEntering().padding(.bottom)
                    }
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
        WordInsertion(
            id: 1, complexity: 123, languageFrom: .russian,
            languageTo: .english,
            descriptionLeft:
                "Lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e",
            descriptionRight:
                "lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e",
            correctWord: "qwerty")
    }
}
