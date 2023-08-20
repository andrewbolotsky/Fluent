//
//  LearningView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 09.08.2023.
//
import SwiftUI
import RoomTime
import Markdown

struct LearningView: View {
    var text: String
    @State var next: Bool = false
    @Binding var exerciseIndex: Int
    var body: some View {
        if !next {
            ScrollView {
                VStack {
                    Markdown(text: text) { element in
                        ElementView(element: element)
                    }
                    .padding()
                    Button(
                        "Submit", action: { next = true }
                    )
                    .padding()
                }
            }
        } else {
            showNextButton(exerciseIndex: $exerciseIndex)
        }
    }
}
//TODO handling errors of markdown
extension Learning: View {

    var body: some View {
        LearningView(
            text: markdownText,
            exerciseIndex: $exerciseIndex)
    }
}
struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        Learning(
            id: UUID().hashValue, complexity: 12,
            languageFrom: .Russian, languageTo: .English,
            markdownText: """
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
                """)
    }
}
