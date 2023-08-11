//
//  ExercisesView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 29.07.2023.
//

import SwiftUI

struct ExercisesView: View {
    @EnvironmentObject var states: GlobalStates
    struct MenuOfChosenExerciseCourse: View {
        @EnvironmentObject var states: GlobalStates
        @Binding var courses: [Course]
        @State var x: Double = 0
        var body: some View {
            NavigationStack {
                List {
                    ForEach(courses) { course in
                        NavigationLink {
                            CourseView().environmentObject(
                                course)
                        } label: {
                            VStack {
                                Text("\(course.name)").font(
                                    .title
                                ).imageScale(.large)
                                    .frame(height: 90)
                                    .bold()
                                ProgressView(value: x)
                                    .onReceive(
                                        states
                                            .$currentCourseIndex,
                                        perform: { _ in
                                            x =
                                                course
                                                .progress
                                        })
                            }
                        }
                    }
                }

            }
        }
    }
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    MenuOfChosenExerciseCourse(
                        courses: $states.readingCourses
                    ).navigationTitle(
                        "Reading")
                } label: {
                    Label("Reading", systemImage: "book")
                        .font(.title).imageScale(.large)
                        .frame(height: 90)
                }
                NavigationLink {
                    MenuOfChosenExerciseCourse(
                        courses: $states
                            .wordInsertionCourses
                    )
                    .navigationTitle(
                        "Insert word")
                } label: {
                    Label(
                        "Insert word",
                        systemImage: "text.insert"
                    ).font(.title).imageScale(.large)
                        .frame(
                            height: 90)
                }
                NavigationLink {
                    MenuOfChosenExerciseCourse(
                        courses: $states.wordCardsCourses
                    ).navigationTitle(
                        "Word Cards"
                    ).environmentObject(states)
                } label: {
                    Label("Word cards", systemImage: "note")
                        .font(.title).imageScale(.large)
                        .frame(
                            height: 90)
                }
                NavigationLink {
                    MenuOfChosenExerciseCourse(
                        courses: $states.crosswordCourses
                    ).navigationTitle(
                        "Crosswords")
                } label: {
                    Label(
                        "Crossword",
                        systemImage:
                            "square.grid.3x1.below.line.grid.1x2"
                    ).font(
                        .title
                    ).frame(
                        height: 90)
                }
                NavigationLink {
                    MenuOfChosenExerciseCourse(
                        courses: $states.speakingCourses
                    ).navigationTitle(
                        "Speaking")
                } label: {
                    Label("Speaking", systemImage: "mic")
                        .font(.title).frame(height: 90)
                }
                NavigationLink {
                    MenuOfChosenExerciseCourse(
                        courses: $states.listeningCourses
                    ).navigationTitle(
                        "Listening")
                } label: {
                    Label(
                        "Listening",
                        systemImage: "headphones"
                    ).font(.title).frame(height: 90)
                }
            }.navigationTitle("Exercises").bold()
        }
    }
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView()
    }
}
