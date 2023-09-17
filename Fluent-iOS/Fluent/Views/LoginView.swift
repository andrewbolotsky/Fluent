//
//  LoginView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 22.08.2023.
//

import SwiftUI
extension Language{
    var value: String? {
        return String(describing: self)
    }
}
extension FluentProto_LanguageLevel{
    var value: String? {
        return String(describing: self)
    }
}
struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var states:GlobalStates
    @State private var selectedFirstLanguage: Language = .english
    @State private var selectedSecondLanguage:Language = .english
    @State private var languageLevel:FluentProto_LanguageLevel = .a1
    @Binding var isStarting:Bool
    private enum Position{
        case chooseWindow
        case loginWindow
        case signupWindow
        case addLanguageWindow
    }
    @State private var window = Position.chooseWindow
    private func initializeCourses(){
        states.crosswordCourses = states.client.getCourses(courseType: .crossword, level: states.level, languageFrom: states.languageFrom, languageTo: states.languageTo, email: states.username,states: states)
        states.wordInsertionCourses = states.client.getCourses(courseType: .wordInsertion, level: states.level, languageFrom: states.languageFrom, languageTo: states.languageTo, email: states.username,states: states)
        
        states.wordInsertionCoursesWithAnswerOptions = states.client.getCourses(courseType: .wordInsertionWithAnswerOptions, level: states.level, languageFrom: states.languageFrom, languageTo: states.languageTo, email: states.username,states: states)
        states.courses = states.client.getCourses(courseType: .general, level: states.level, languageFrom: states.languageFrom, languageTo: states.languageTo, email: states.username,states: states)
        states.readingCourses = states.client.getCourses(courseType: .reading, level: states.level, languageFrom: states.languageFrom, languageTo: states.languageTo, email: states.username,states: states)
        states.wordCardsCourses = states.client.getCourses(courseType: .wordCards, level: states.level, languageFrom: states.languageFrom, languageTo: states.languageTo, email: states.username,states: states)
        states.speakingCourses = states.client.getCourses(courseType: .speaking, level: states.level, languageFrom: states.languageFrom, languageTo: states.languageTo, email: states.username,states: states)
        states.listeningCourses = states.client.getCourses(courseType: .listening, level: states.level, languageFrom: states.languageFrom, languageTo: states.languageTo, email: states.username,states: states)
    }
    private func signUp()->some View{
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    
                    if states.client.signUp(username: email, password: password){
                        states.username = email
                        states.password = password
                        window = .addLanguageWindow
                    }
                }) {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
    func logIn()->some View{
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            chooseLanguages()
            Button(action: {
                if let value = states.client.logIn(username: email, password: password, languageFrom: selectedFirstLanguage, languageTo: selectedSecondLanguage){
                    states.username = email
                    states.password = password
                    states.languageFrom = selectedFirstLanguage
                    states.languageTo = selectedSecondLanguage
                    states.level = value
                    initializeCourses()
                    isStarting = false

                }
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
    func chooseLanguages()->some View{
        VStack{
            VStack{
                Text("Language you know:")
                    .font(.headline)
                    .padding()
                
                Picker(selection: $selectedFirstLanguage, label: Text("Language you know:")) {
                    ForEach(Language.allCases, id: \.self) { language in
                        Text(language.value?.uppercased() ?? "no language")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding(.horizontal)
                
                .padding()
            } .background(LinearGradient(gradient: Gradient(colors: [Color.accentColor, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(20)
                .shadow(radius: 10)
            VStack {
                Text("Language you want to know:")
                    .font(.headline)
                    .padding(.bottom)
                
                Picker(selection: $selectedSecondLanguage, label: Text("Language you want to know:")) {
                    ForEach(Language.allCases, id: \.self) { language in
                        Text(language.value?.uppercased() ?? "no language")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding(.horizontal)
            }
            .padding() .background(LinearGradient(gradient: Gradient(colors: [Color.accentColor,.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            .shadow(radius: 10)
            
        }
    }
    func addLanguage()->some View{
        VStack {
            chooseLanguages();
            VStack {
                Text("Your level:")
                    .font(.headline)
                    .padding(.bottom)
                
                Picker(selection: $languageLevel, label: Text("Your level:")) {
                    ForEach(FluentProto_LanguageLevel.allCases, id: \.self) { level in
                        Text(level.value?.uppercased() ?? "no level")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding(.horizontal)
            }
            .padding()
            
            .background(LinearGradient(gradient: Gradient(colors: [Color.accentColor,.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            .shadow(radius: 10)
            Button(action: {
                if states.client.addLanguageToUser(username: states.username, password: states.password, level: languageLevel.rawValue , languageFrom: selectedFirstLanguage, languageTo: selectedSecondLanguage){
                    states.languageFrom = selectedFirstLanguage
                    states.languageTo = selectedSecondLanguage
                    states.level = languageLevel.rawValue
                    print()
                    print()
                    print()
                    print()
                    print("level: \(states.level)")
                    print("language from: \(states.languageFrom)")
                    print("language to: \(states.languageTo)")
                    print()
                    print()
                    print()
                    print()
                    initializeCourses()
                    isStarting = false

                }
            }) {
                Text("GO")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(10)
                
            }
            .padding()
        }
    }
    func chooseWindow()->some View{
        VStack {
                    Text("Hello!")
                        .font(.largeTitle)
                        .padding(.bottom, 50)
                    
                    Button(action: {
                        window = .signupWindow
                    }) {
                        Text("Sign Up")
                            .font(.title)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        window = .loginWindow
                    }) {
                        Text("Log in")
                            .font(.title)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }

    }
    var body: some View {
        if window == .chooseWindow{
            chooseWindow()
        }
        if window == .addLanguageWindow{
            addLanguage()
        }
        if window == .loginWindow{
            logIn()
        }
        if window == .signupWindow{
            signUp()
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isStarting: .constant(true))
    }
}
