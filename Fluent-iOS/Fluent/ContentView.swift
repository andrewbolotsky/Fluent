//
//  ContentView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 29.07.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var states: GlobalStates = GlobalStates()
    @State var isStarting = true
    var body: some View {
        if isStarting{
            LoginView(isStarting: $isStarting).environmentObject(states)
        }
        else{
            TabView {
                CourseView().tabItem {
                    Image(
                        systemName:
                            "app.connected.to.app.below.fill"
                    ).foregroundColor(.accentColor)
                    Text("Course")
                }.environmentObject(
                    Course(lessons: [], allLessonsCount: 1,states: states))
                EntertainmentView().tabItem {
                    Image(
                        systemName: "arrowtriangle.right.fill"
                    ).foregroundColor(.accentColor)
                    Text("Entertainment")
                }
                ExercisesView().tabItem {
                    Image(systemName: "books.vertical.fill")
                        .foregroundColor(.accentColor)
                    Text("Exercises")
                }
                AccountView().tabItem {
                    Image(systemName: "person.fill")
                        .foregroundColor(.accentColor)
                    Text("Account")
                }
            }.environmentObject(states)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
