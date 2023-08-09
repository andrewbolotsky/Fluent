//
//  SettingsView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 08.08.2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var states:GlobalStates
    var body: some View {
        NavigationStack {
            List {
                
                NavigationLink(destination: Text("Notifications Settings")) {
                    Label("Notifications",systemImage: "bell").font(.title).frame(height: 90)
                }
                
                NavigationLink(destination: Text("Theme Settings")) {
                    Label("Theme",systemImage: "lightbulb").font(.title).frame(height: 90)
                }
                
                NavigationLink(destination: Text("Interface language settings")) {
                    Label("Interface language",systemImage: "globe").font(.title).frame(height: 90)
                }
            }
            .navigationTitle("Settings")
        }.bold()
    }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
