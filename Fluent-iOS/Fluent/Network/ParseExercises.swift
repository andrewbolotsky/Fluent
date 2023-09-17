//
//  ParseExercises.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 22.08.2023.
//

import Foundation

fileprivate func parseCrossword(exercise:FluentProto_Exercise)->Crossword?{
    /*
     {"hints":["This is empty word","This is empty word","This is empty word"],"crossword":[[{"isGuessed":false,"hint":"0","isBlocked":false},{"isGuessed":false,"hint":"","isBlocked":true},{"isGuessed":false,"hint":"","isBlocked":false},{"isGuessed":false,"hint":"","isBlocked":false}],[{"isGuessed":false,"hint":"","isBlocked":false},{"isGuessed":false,"hint":"","isBlocked":true},{"isGuessed":false,"hint":"","isBlocked":false},{"isGuessed":false,"hint":"","isBlocked":false}],[{"isGuessed":false,"hint":"","isBlocked":false},{"isGuessed":false,"hint":"","isBlocked":false},{"isGuessed":false,"hint":"","isBlocked":false},{"isGuessed":false,"hint":"","isBlocked":true}],[{"isGuessed":false,"hint":"","isBlocked":false},{"isGuessed":false,"hint":"","isBlocked":false},{"isGuessed":false,"hint":"","isBlocked":true},{"isGuessed":false,"hint":"","isBlocked":false}]],"correctAnswers":[["","","",""],["","","",""],["","","",""],["","","",""]]}
     */
    struct InternalCrossword:Codable{
        var correctAnswers:[[String]]
        var hints:[String]
        var crossword:[[CrosswordCell]]
    }
    var internalCrossword:InternalCrossword?
        // make sure this JSON is in the format we expect
    if let decoded = try? JSONDecoder().decode(InternalCrossword.self, from: Data(exercise.content.utf8)) {
        internalCrossword = decoded
    }
    var correctAnswers = internalCrossword?.correctAnswers ?? []
    var hints = internalCrossword?.hints ?? []
    var crossword = internalCrossword?.crossword ?? [[]]
    return Crossword(id: Int(exercise.id), complexity: Int(exercise.complexity), languageFrom: exercise.languageFrom, languageTo: exercise.languageTo, correctAnswers: correctAnswers, crossword: crossword ,hints: hints)
}
fileprivate func parseLearning(exercise:FluentProto_Exercise)->Learning?{
    /*
     "{\"text\": "Lorem ipsum"}"
     */
    var markdownText:String = ""
    do {
        if let json = try JSONSerialization.jsonObject(with: Data(exercise.content.utf8), options: []) as? [String: Any] {
            if let text = json["text"] as? String {
                markdownText = text
            }
        }
    } catch let error as NSError {
        print("Failed to load: \(error.localizedDescription)")
        return nil
    }
    return Learning(id: Int(exercise.id), complexity: Int(exercise.complexity), languageFrom: exercise.languageFrom, languageTo: exercise.languageTo, markdownText: markdownText)
    
}
fileprivate func parseReading(exercise:FluentProto_Exercise)->Reading?{
    /*
     {
       "exercises": [
         {
           "id": 12,
           "description": "Water freezes at 0 degrees",
           "correctAnswer": true
         },
         {
           "id": 13,
           "description": "Water freezes at 100 degrees",
           "correctAnswer": false
         }
       ],
       "name": "Lorem",
       "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed faucibus sed risus non facilisis. Morbi condimentum lorem eu eros tincidunt elementum. Suspendisse mollis, odio at mattis porttitor, purus urna consequat quam, nec sodales lacus diam eu lectus. Praesent id ex ullamcorper tellus dapibus rutrum. Nullam accumsan lacus efficitur iaculis molestie. Sed lobortis, odio at iaculis elementum, orci eros porta eros, sed auctor magna sem sed urna. Donec quis tellus interdum, efficitur felis in, egestas est. Ut id fermentum dui, in sagittis ex. Nunc sed consectetur enim. Sed volutpat egestas justo, a dictum nisi hendrerit id. Sed pharetra tincidunt ipsum, eget fermentum metus sodales in. Quisque finibus sodales dictum.Fusce tellus nunc, viverra non orci ut, commodo maximus massa. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Phasellus sit amet est volutpat, mollis risus ut, tempor nisi. Donec porttitor, purus vitae dictum placerat, ligula tellus sagittis sem, sed pharetra ligula urna et erat. Praesent blandit lacus non posuere tristique. Nullam in lacus mollis, dictum felis ut, tincidunt nibh. Sed neque erat, tincidunt eu pharetra eu, sollicitudin feugiat lorem. Fusce et tristique nulla. Morbi egestas lectus ac lorem convallis, sit amet efficitur ante dictum. Etiam consectetur maximus sapien, nec commodo eros pretium at. Aenean laoreet mi a arcu volutpat, ut dapibus odio suscipit. Fusce accumsan lobortis cursus. Donec sed nisl non sapien feugiat porttitor. Maecenas vel arcu sed tellus placerat dapibus ut quis velit.Donec porta mattis justo at sodales. In vel tincidunt tellus. Ut lorem arcu, posuere et feugiat in, aliquet ac nisi. Aenean vestibulum est non tortor mollis, at congue justo viverra. Duis iaculis rhoncus finibus. Nulla viverra, est et suscipit varius, libero nisl laoreet arcu, et dignissim massa metus non ipsum. Praesent rhoncus egestas arcu. Nullam auctor, nulla non condimentum tincidunt, odio enim vestibulum libero, nec interdum nisl lacus ac diam. Etiam pretium tempus risus imperdiet accumsan. In lacinia quam vitae dui gravida lacinia. Sed interdum egestas dui sit amet tristique. Proin sit amet nunc eget urna pulvinar pharetra. Ut at hendrerit neque. Pellentesque sed leo ipsum. Quisque dignissim viverra urna, ac vulputate ipsum porta nec. Donec tincidunt ex et sollicitudin congue. Nam dignissim sem non maximus semper. Vestibulum sollicitudin sem eu vehicula pulvinar. Curabitur interdum lacinia ante, eu varius nunc porttitor quis. Quisque tempor non urna at mollis. Etiam porta lorem ut nunc pellentesque laoreet nec a dolor. Mauris molestie, odio eget varius blandit, nisi est euismod elit, id facilisis nulla leo vel mauris. Donec neque felis, pretium quis est eu, suscipit mattis justo. Pellentesque quis felis leo. Morbi mauris dolor, euismod dignissim commodo et, eleifend gravida neque. Fusce varius lectus tortor, aliquet tempus nibh eleifend ut. Praesent sed nulla vestibulum, dignissim lectus sed, elementum metus. Quisque arcu nunc, tincidunt id malesuada venenatis, consequat in dui. Vivamus imperdiet non magna in vestibulum. Maecenas mollis volutpat felis quis dignissim."
     }
     */
    struct ReadingExercise:Codable{
        var id:Int
        var description:String
        var correctAnswer:Bool
    }
    struct InternalReading:Codable{
        var name:String
        var exercises:[ReadingExercise]
        var text:String
    }
    var name:String = ""
    var text:String = ""
    var exercises:[ReadingExercise] = []
    if let decoded = try? JSONDecoder().decode(InternalReading.self, from: Data(exercise.content.utf8)) {
        name = decoded.name
        text = decoded.text
        exercises = decoded.exercises
    }
    var value:[Reading.TrueFalseExercise] = []
    for exercise in exercises{
        value.append(Reading.TrueFalseExercise(id: exercise.id, description: exercise.description, correctAnswer: exercise.correctAnswer))
    }
    return Reading(id: Int(exercise.id), complexity: Int(exercise.complexity), languageFrom: exercise.languageFrom, languageTo: exercise.languageTo, name: name, text: text, exercises: value)
}
fileprivate func parseWordCards(exercise:FluentProto_Exercise)->WordCards?{
    /*
     {
     "cards":[{"from":"Lorem", "to":"Ipsum"},{"from":"mother", "to":"мать"}]
     }
     */
    struct Card:Codable{
        var from:String
        var to:String
    }
    struct Cards:Codable{
        var cards: [Card]
    }
    var internalCards:[Card] = []
    if let decoded = try? JSONDecoder().decode(Cards.self, from: Data(exercise.content.utf8)) {
        internalCards = decoded.cards
    }
    var cards:[WordCards.Card] = []
    for value in internalCards{
        cards.append(WordCards.Card(wordFrom:value.from,wordTo:value.to))
    }
    return WordCards(id: Int(exercise.id), complexity: Int(exercise.complexity), languageFrom: exercise.languageFrom, languageTo: exercise.languageTo, cards: cards)
}
fileprivate func parseWordInsertion(exercise:FluentProto_Exercise)->WordInsertion?{
    /*
     {  "descriptionLeft":"Lorem"
        "descriptionRight":"Ipsum"
        "correctWord":"armet"
     }
     */
    var descriptionLeft:String = ""
    var descriptionRight:String = ""
    var correctWord:String = ""
    do {
        if let json = try JSONSerialization.jsonObject(with: Data(exercise.content.utf8), options: []) as? [String: Any] {
            if let left = json["descriptionLeft"] as? String {
                descriptionLeft = left
            }
            if let right = json["descriptionRight"] as? String {
                descriptionRight = right
            }
            if let word = json["correctWord"] as? String{
                correctWord = word
            }
        }
    } catch let error as NSError {
        print("Failed to load: \(error.localizedDescription)")
        return nil
    }
    return WordInsertion(id: Int(exercise.id), complexity: Int(exercise.complexity), languageFrom: exercise.languageFrom, languageTo: exercise.languageTo, descriptionLeft: descriptionLeft, descriptionRight: descriptionRight, correctWord: correctWord)
}
fileprivate func parseWordInsertionWithAnswerOptions(exercise:FluentProto_Exercise)->WordInsertionWithAnswerOptions?{
    /*
     {"descriptionLeft":"Lorem"
        "descriptionRight":"Ipsum"
        "correctWord":"armet"
        "answerOptions":["lorem","armet","ipsum","am"]
     }
     */
    var descriptionLeft:String = ""
    var descriptionRight:String = ""
    var correctWord:String = ""
    var answerOptions:[String] = []
    do {
        if let json = try JSONSerialization.jsonObject(with: Data(exercise.content.utf8), options: []) as? [String: Any] {
            if let left = json["descriptionLeft"] as? String {
                descriptionLeft = left
            }
            if let right = json["descriptionRight"] as? String {
                descriptionRight = right
            }
            if let word = json["correctWord"] as? String{
                correctWord = word
            }
            if let options = json["answerOptions"] as? [String]{
                answerOptions = options
            }
        }
    } catch let error as NSError {
        print("Failed to load: \(error.localizedDescription)")
        return nil
    }
    return WordInsertionWithAnswerOptions(id: Int(exercise.id), complexity: Int(exercise.complexity), languageFrom: exercise.languageFrom, languageTo: exercise.languageTo, descriptionLeft: descriptionLeft, descriptionRight: descriptionRight, correctWord: correctWord,answersOptions: answerOptions)
}
fileprivate func parseSpeaking(exercise:FluentProto_Exercise)->SpeakingExercise?{
    /*
     {\"correctAnswer\": "Lorem ipsum"}"
     */
    struct Ans:Codable{
        var correctAnswer:String
    }
    var correctAnswer:String = ""
    let ans:Ans = try! JSONDecoder().decode(Ans.self, from: Data(exercise.content.utf8))
    correctAnswer = ans.correctAnswer
    return SpeakingExercise(id: Int(exercise.id), complexity: Int(exercise.complexity), languageFrom: exercise.languageFrom, languageTo: exercise.languageTo, correctAnswer: correctAnswer)
}
func parseExercise(exercise:FluentProto_Exercise)->(any Exercise)?{
    switch exercise.type{
    case .crossword:
        return parseCrossword(exercise: exercise)
    case .learning:
        return parseLearning(exercise: exercise)
    case .reading:
        return parseReading(exercise:exercise)
    case .wordCards:
        return parseWordCards(exercise:exercise)
    case .wordInsertion:
        return parseWordInsertion(exercise: exercise)
    case .wordInsertionWithAnswerOptions:
        return parseWordInsertionWithAnswerOptions(exercise: exercise)
    case .speaking:
        return parseSpeaking(exercise:exercise)
    default:
        return nil
    }
}
