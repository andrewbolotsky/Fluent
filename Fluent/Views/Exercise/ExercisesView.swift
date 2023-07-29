//
//  ExercisesView.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 29.07.2023.
//

import SwiftUI

struct ExercisesView: View {
    var body: some View {
        NavigationStack{
            List{
                NavigationLink{
                    VStack{
                        Reading(id: 1, complexity: 1, languageFrom: LanguageFrom.Russian, languageTo: LanguageTo.English, name: "Lorem Ipsum", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?", exercises: [Reading.TrueFalseExercise(id:12312,description: "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born ", correctAnswer: true),Reading.TrueFalseExercise(id: 1123,description: "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born ", correctAnswer: true)])
                    }
                }label:{
                    Label("Reading",systemImage: "book").font(.title)                .imageScale(.large)
                        .frame(height: 90)
                }
                NavigationLink{
                    WordInsertion(id: 1, complexity: 123, languageFrom: .Russian, languageTo: .English, descriptionLeft: "Lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e", descriptionRight: "lorem ipsum dolor sit armet qwer qqq weew wewq qwe qqq qqq w e r w w q w e", correctWord: "qwerty")
                }label:{
                    Label("Insert word",systemImage: "text.insert").font(.title).frame(height: 90)
                }
                NavigationLink{
                    WordCards(id:1231212,complexity: 40,languageFrom: .Russian,languageTo: .English,cards:[WordCards.Card(wordFrom: "лошадь", wordTo: "horse"),WordCards.Card(wordFrom: "курица", wordTo: "chicken"),WordCards.Card(wordFrom: "мама", wordTo: "mother")])
                }label:{
                    Label("Word cards",systemImage: "note").font(.title).frame(height: 90)
                }
                
                NavigationLink{
                    ComingSoonView()
                }label:{
                    Label("Crossword",systemImage: "square.grid.3x1.below.line.grid.1x2").font(.title).frame(height: 90)
                }
                NavigationLink{
                    ComingSoonView()
                }label:{
                    Label("Speaking",systemImage: "mic").font(.title).frame(height: 90)
                }
                NavigationLink{
                    ComingSoonView()
                }label:{
                    Label("Listening",systemImage: "headphones").font(.title).frame(height: 90)
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
