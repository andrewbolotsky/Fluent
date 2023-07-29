//
//  EntertainmentView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 29.07.2023.
//

import SwiftUI

struct EntertainmentView: View {
    var body: some View {
        NavigationStack{
            List{
                NavigationLink{
                    ComingSoonView()
                }label:{
                    Spacer()
                    Label("E-Books",systemImage: "book").font(.title).dynamicTypeSize(.large).frame(height: 100)
                }
                NavigationLink{
                    ComingSoonView()
                }label:{
                    Spacer()
                    Label("Movies",systemImage: "film").font(.title).frame(height: 100)
                    Spacer()
                }
            }.navigationTitle("Entertainment").bold()
        }    }
}

struct EntertainmentView_Previews: PreviewProvider {
    static var previews: some View {
        EntertainmentView()
    }
}
