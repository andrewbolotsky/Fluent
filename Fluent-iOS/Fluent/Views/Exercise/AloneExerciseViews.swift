//
//  AloneExerciseViews.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 29.07.2023.
//

import SwiftUI
func showNextButton(exerciseIndex: Binding<Int>)
    -> some View
{
    Button {
        exerciseIndex.wrappedValue += 1
    } label: {
        VStack {
            Image(systemName: "arrow.forward")
                .font(.system(size: 100))

        }
    }
}
struct NextActionButton: View {
    @Binding var isSet: Bool
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label(
                "Next Action",
                systemImage: isSet
                    ? "arrowtriangle.right.fill"
                    : "arrowtriangle.right"
            )
            .foregroundColor(.white)
        }.padding(10).background(Color("AccentColor"))
            .clipShape(
                RoundedRectangle.init(cornerRadius: 10))
    }
}


