//
//  AloneExerciseViews.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 29.07.2023.
//

import SwiftUI

struct NextActionButton:View{
    @Binding var isSet:Bool
    var body:some View{
        Button {
            isSet.toggle()
        } label: {
            Label("Next Action", systemImage: isSet ? "arrowtriangle.right.fill" : "arrowtriangle.right")
                .foregroundColor(.white)
        }.padding(10).background(Color("AccentColor")).clipShape(RoundedRectangle.init(cornerRadius: 10))
    }
}

struct CorrectnessLabel:View{
    var isUserAnswerCorrect:Bool
    var body:some View{
        if isUserAnswerCorrect{
            Label("You are absolutely right", systemImage: "checkmark" )
                    .foregroundColor(.green)
        }
        else{
            Label("You are not right", systemImage: "xmark" )
                    .foregroundColor(.red)
        }
    }
}
