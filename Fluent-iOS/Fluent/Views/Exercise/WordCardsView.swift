//
//  WordCardsView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 30.07.2023.
//

import SwiftUI

extension WordCards {
    private func autoHidingNextButton() -> some View {
        HStack {
            Spacer()
            VStack {
                if showTranslate {
                    Button(action: {
                        currentCard = getNewCard()
                        showTranslate = false
                    }) {
                        Text("Submit")
                            .font(.subheadline)
                            .padding()
                            .background(
                                Color.accentColor
                            )
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                } else {
                    Spacer().frame(height: 70)
                }
            }
            Spacer()
        }
    }
    private func changeStack(
        card: Card, isUserKnowsWord: Bool
    ) {
        if isUserKnowsWord {
            if card.conditionType == .InProgressWord {
                let firstIndex = self.currentCardStack
                    .firstIndex(where: {
                        card.wordTo == $0.wordTo
                            && card.wordFrom == $0.wordFrom
                    })
                if firstIndex != nil {
                    self.currentCardStack.remove(
                        at: firstIndex!)
                }
            } else {
                self.currentCardStack.append(card)
                for index in 0..<currentCardStack.count {
                    if currentCardStack[index].wordTo
                        == card.wordTo
                        && currentCardStack[index].wordFrom
                            == card.wordFrom
                    {
                        currentCardStack[index]
                            .conditionType = .InProgressWord
                    }
                }
            }
        } else {
            currentCardStack.append(card)
            currentCardStack.append(card)
            for index in 0..<currentCardStack.count {
                if currentCardStack[index].wordTo
                    == card.wordTo
                    && currentCardStack[index].wordFrom
                        == card.wordFrom
                {
                    currentCardStack[index].conditionType =
                        .NewWord
                }
            }
        }
    }
    private func showCard(card: Card) -> some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Spacer()
                    Spacer()

                    HStack {
                        Spacer()
                        if showTranslate {
                            Text(card.wordFrom).font(
                                .largeTitle
                            ).bold()
                        } else {
                            Text(card.wordTo).font(
                                .largeTitle
                            ).bold()
                        }
                        Spacer()
                    }
                    Spacer()
                    Spacer()

                    HStack {
                        Button {
                            showTranslate = true
                            changeStack(
                                card: card,
                                isUserKnowsWord: true)
                        } label: {
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .padding()
                                .dynamicTypeSize(
                                    .xxxLarge)

                            Spacer()

                        }.background(Color("AccentColor"))
                        Button {
                            showTranslate = true
                            changeStack(
                                card: card,
                                isUserKnowsWord: false)
                        } label: {
                            Spacer()
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .padding()
                                .dynamicTypeSize(.xxxLarge)
                            Spacer()
                        }.background(Color("AccentColor"))
                    }
                }.background().frame(height: 400).border(
                    Color(.black)
                ).clipShape(
                    RoundedRectangle(cornerRadius: 10)
                ).frame(maxWidth: 600).frame(maxHeight: 600)
                    .frame(minWidth: 300).frame(
                        minHeight: 300)
                Spacer()
            }
            autoHidingNextButton()

        }
    }

    private func getNewCard() -> Card? {
        guard !currentCardStack.isEmpty else {
            return nil
        }
        currentCardStack.shuffle()
        let newCard = currentCardStack.last
        currentCardStack.removeLast()
        return newCard
    }

    var body: some View {
        VStack {
            Spacer()
            if currentCard != nil {
                showCard(card: currentCard!)
            } else {
                showNextButton(
                    exerciseIndex: $exerciseIndex)
            }
            Spacer()

        }.onAppear {
            self.currentCardStack = self.cards
            currentCard = getNewCard()

        }

    }
}

struct WordCardsView_Previews: PreviewProvider {
    static var previews: some View {
        WordCards(
            id: 1_231_212, complexity: 40,
            languageFrom: .russian, languageTo: .english,
            cards: [
                WordCards.Card(
                    wordFrom: "лошадь", wordTo: "horse"),
                WordCards.Card(
                    wordFrom: "курица", wordTo: "chicken"),
                WordCards.Card(
                    wordFrom: "мама", wordTo: "mother"),
                WordCards.Card(
                    wordFrom: "папа", wordTo: "father"),
                WordCards.Card(
                    wordFrom: "окружающая среда",
                    wordTo: "environment"),
                WordCards.Card(
                    wordFrom: "дерево", wordTo: "tree"),
            ])
    }
}
