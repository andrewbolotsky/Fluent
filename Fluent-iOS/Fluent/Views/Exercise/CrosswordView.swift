//
//  CrosswordView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 04.08.2023.
//
import SwiftUI

private struct CrosswordGameView: View {
    @StateObject var crosswordGame: CrosswordGame
    @State var isSubmitted = false
    var body: some View {
        if crosswordGame.isCorrect != true {
            VStack {
                Spacer().frame(
                    minHeight: 100, maxHeight: 200)
                VStack {
                    CrosswordView(
                        crosswordGame: crosswordGame
                    ).padding(15)

                }
                List {
                    ForEach(
                        0..<crosswordGame.hints.count,
                        id: \.self
                    ) { index in
                        Text(
                            "\(index): \(crosswordGame.hints[index])"
                        ).font(.subheadline)
                    }
                }.listStyle(.inset).frame(
                    height: CGFloat(
                        60 * crosswordGame.hints.count))
                Button(action: {
                    crosswordGame.checkAnswers()
                }) {
                    Text("Submit")
                        .font(.subheadline)
                        .padding()
                        .background(
                            isSubmitted == false
                                || crosswordGame.isCorrect
                                    == nil
                                || crosswordGame.isCorrect
                                    == true
                                ? Color.accentColor
                                : Color.red
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                if crosswordGame.isCorrect != nil {
                    if crosswordGame.isCorrect! {
                        Text("You are right")
                    } else {
                        Text("You are not right")
                    }
                }
            }
            //.navigationTitle("Crossword")
        } else {
            showNextButton(
                exerciseIndex: crosswordGame.$exerciseIndex)
        }
    }
}
private struct CrosswordTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>)
        -> some View
    {
        configuration
            .multilineTextAlignment(.center)
            .font(
                Font.system(
                    size: 20, weight: .bold,
                    design: .default)
            )
            .padding(10)
            .background(Color("AccentColor"))
            .cornerRadius(10)
    }
}
private struct CrosswordView: View {
    @ObservedObject var crosswordGame: CrosswordGame

    var body: some View {
        VStack {
            ForEach(
                0..<crosswordGame.crossword.count,
                id: \.self
            ) { row in
                HStack {
                    ForEach(
                        0..<crosswordGame.crossword[row]
                            .count, id: \.self
                    ) { column in
                        let cell = crosswordGame.crossword[
                            row][column]

                        if cell.isBlocked {
                            Text("")
                                .frame(
                                    width: 40, height: 40)
                        } else {
                            TextField(
                                crosswordGame.crossword[
                                    row][column].hint,
                                text: Binding(
                                    get: {
                                        crosswordGame
                                            .answers[row][
                                                column]
                                    },
                                    set: {
                                        crosswordGame
                                            .answers[row][
                                                column] =
                                            $0.uppercased()
                                    }
                                )
                            )
                            .textFieldStyle(
                                CrosswordTextFieldStyle()
                            )
                            .frame(width: 40, height: 40)
                            .background(Color.white)
                            .multilineTextAlignment(.center)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .onTapGesture {
                                crosswordGame.selectCell(
                                    row: row, column: column
                                )
                            }
                        }
                    }
                }
                .padding(1)
            }
        }
        .padding()
    }
}

private class CrosswordGame: ObservableObject {
    @Published var isCorrect: Bool?
    @Binding var exerciseIndex: Int
    @Published var crossword: [[CrosswordCell]]
    var hints: [String]
    @Published var answers: [[String]]
    @Published var correctAnswers: [[String]]

    init(
        crossword: [[CrosswordCell]],
        correctAnswers: [[String]],
        exerciseIndex: Binding<Int>,
        hints: [String]
    ) {
        self.crossword = crossword
        self.correctAnswers = correctAnswers
        self.answers = correctAnswers
        self.isCorrect = nil
        self._exerciseIndex = exerciseIndex
        self.hints = hints
        for indexX in 0..<answers.count {
            for indexY in 0..<answers[indexX].count {
                answers[indexX][indexY] = ""
            }
        }
    }
    func selectCell(row: Int, column: Int) {
        let cell = crossword[row][column]
        if !cell.isBlocked {
            crossword[row][column].isGuessed.toggle()
        }
    }

    func checkAnswers() {
        var isCorrect = true
        for indexX in 0..<answers.count {
            for indexY in 0..<answers[indexX].count {
                if answers[indexX][indexY]
                    != correctAnswers[indexX][indexY]
                {
                    isCorrect = false
                    break
                }
            }
            if !isCorrect {
                break
            }
        }
        self.isCorrect = isCorrect
    }
}
extension Crossword: View {
    var body: some View {
        CrosswordGameView(
            crosswordGame: CrosswordGame(
                crossword: crossword,
                correctAnswers: correctAnswers,
                exerciseIndex: $exerciseIndex,
                hints: hints))
    }
}

struct CrosswordView_Previews: PreviewProvider {
    static var previews: some View {
        Crossword(
            id: 3432, complexity: 12,
            languageFrom: .russian, languageTo: .english,
            exerciseIndex: .constant(0),
            correctAnswers: Array(
                repeating: Array(repeating: "", count: 4),
                count: 4),
            crossword: [
                [
                    CrosswordCell(
                        isBlocked: false, isGuessed: false,
                        hint: "0"),
                    CrosswordCell(
                        isBlocked: true, isGuessed: false),
                    CrosswordCell(
                        isBlocked: false, isGuessed: false),
                    CrosswordCell(
                        isBlocked: false, isGuessed: false),
                ],

                [
                    CrosswordCell(
                        isBlocked: false, isGuessed: false),
                    CrosswordCell(
                        isBlocked: true, isGuessed: false),
                    CrosswordCell(
                        isBlocked: false, isGuessed: false),
                    CrosswordCell(
                        isBlocked: false, isGuessed: false),
                ],

                [
                    CrosswordCell(
                        isBlocked: false, isGuessed: false),
                    CrosswordCell(
                        isBlocked: false, isGuessed: false),
                    CrosswordCell(
                        isBlocked: false, isGuessed: false),
                    CrosswordCell(
                        isBlocked: true, isGuessed: false),
                ],

                [
                    CrosswordCell(
                        isBlocked: false, isGuessed: false),
                    CrosswordCell(
                        isBlocked: false, isGuessed: false),
                    CrosswordCell(
                        isBlocked: true, isGuessed: false),
                    CrosswordCell(
                        isBlocked: false, isGuessed: false),
                ],
            ],
            hints: [
                "This is empty word", "This is empty word",
                "This is empty word",
            ])
    }
}
