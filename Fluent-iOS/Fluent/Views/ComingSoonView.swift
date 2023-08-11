//
//  ComingSoonView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 29.07.2023.
//

import SwiftUI

struct ComingSoonView: View {
    var body: some View {
        VStack {
            Text("Coming soon.").bold().fontWeight(.heavy)
            Text(
                "This part of application haven't done yet."
            )
        }
    }
}

struct ComingSoonView_Previews: PreviewProvider {
    static var previews: some View {
        ComingSoonView()
    }
}
