//
//  AccountView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 01.08.2023.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var states: GlobalStates
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    NavigationLink {
                        ComingSoonView()
                    } label: {
                        Label(
                            "Your languages",
                            systemImage: "globe"
                        ).font(.title).frame(height: 90)
                    }
                    NavigationLink {
                        SettingsView().environmentObject(
                            states)
                    } label: {
                        Label(
                            "Settings", systemImage: "gear"
                        ).font(.title).frame(height: 90)
                    }
                    NavigationLink {
                        SettingsView().environmentObject(
                            states)
                    } label: {
                        Label(
                            "Log out",
                            systemImage:
                                "door.left.hand.open"
                        ).font(.title).frame(
                            height: 90)
                    }
                }.navigationTitle(
                    "\(states.firstName) \(states.secondName)"
                ).bold()
            }
        }

    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
