//
//  CourseView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 29.07.2023.
//

import SwiftUI

struct GeneralButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding().frame(width: 300,height:300)
            .background(Color("AccentColor"))
            .foregroundStyle(.white)
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            
    }
}

struct CourseView: View {
    @State private var isRotating = 0.0
    @EnvironmentObject var course:Course
    var body: some View {
        if !course.newAction{
            VStack{
                Spacer()
                Spacer()
                Text("Your course").bold().font(.largeTitle)
                Spacer()
                Button {
                    course.newAction = true;
                }label: {
                    VStack{
                
                        Image("CourseButton")
                            .font(.system(size: 100))
                            .rotationEffect(.degrees(isRotating))
                            
                    }
                }
                .buttonStyle(GeneralButtonStyle()).font(.title).bold().onReceive(course.$newAction,perform: {value in
                    print()
                    print("newAction changed and GeneralButtonStyle got it \(value)")
                    print()
                    if !value{
                        isRotating = 0
                        withAnimation(.linear(duration: 1)
                            .speed(0.1).repeatForever(autoreverses: false)) {
                                isRotating = 360.0
                            }
                    }
                })
                Spacer()
                HStack{
                    Spacer()
                    ProgressView(value: course.progress)
                    Spacer()

                }
                Spacer()
                Spacer()
            }
        }
        else{
            if course.newLesson == nil{
                ComingSoonView()
            }
            else{
                VStack{
                    course.newLesson!.environmentObject(course)
                }.onAppear{
                    course.initNewLessonWithNewAction(newAction: $course.newAction)
                }
            }
        }
    }
}


struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView()
    }
}
