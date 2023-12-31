//
//  ExerciseModel.swift
//  Fluent
//
//  Created by Андрей Болоцкий on 29.07.2023.
//

import Foundation
import SwiftUI


enum KnowledgeLevel {
    case A1
    case A2
    case B1
    case B2
    case C1
    case C2
}
typealias LanguageTo = FluentProto_Language
typealias LanguageFrom = FluentProto_Language
class Course: ObservableObject, Identifiable {
    var id:Int = UUID().hashValue
    var name = ""
    private var lessons: [Lesson] = Array()
    private(set) var allLessonsCount: Int
    @Published var progress: Double = 0
    @Published var newAction = false
    @Published var isLessonDone: Bool = false
    @Published var exercisesIndex: Int = 0
    weak var states:GlobalStates?
    var userLessonIndex:Int = 0;
    init (id:Int,name:String,allLessonsCount:Int, userLessonIndex:Int,states:GlobalStates){
        self.id = id
        self.name = name
        self.lessons = []
        self.allLessonsCount = allLessonsCount
        self.userLessonIndex = userLessonIndex
        self.states = states
    }
    init(lessons: [Lesson], allLessonsCount: Int,states:GlobalStates) {
        self.lessons = lessons
        self.allLessonsCount = allLessonsCount
        self.states = states
    }
    init(
        name: String, lessons: [Lesson],
        allLessonsCount: Int,states:GlobalStates
    ) {
        self.name = name
        self.lessons = lessons
        self.allLessonsCount = allLessonsCount
        self.states = states
    }
    func initNewLessonWithNewAction(
        newAction: Binding<Bool>
    ) {
        let lesson = newLesson
        if lesson != nil{
            lessons.append(lesson!)
            lessons[0] = Lesson(
                lessons[0], newLesson: newAction)
        }
    }
    func append(lesson: Lesson) {
        lessons.append(lesson)
    }
    var newLesson: Lesson? {
         states?.client.getLesson(course: self) ?? nil
    }
    func deleteLesson() {
        lessons.removeLast()
        let value = states?.client.lessonIsDone(courseId: self.id, email: states?.username ?? "")
        self.id = Int(value?.id ?? 0)
        self.name = value?.name ?? ""
        self.allLessonsCount = Int(value?.lessonsCount ?? 0)
        self.userLessonIndex = Int((value?.userLessonIndex ?? 0))
    }
}

struct Lesson {
    init(
        name: String, complexity: KnowledgeLevel,
        exercises: [any Exercise],
        newLesson: Binding<Bool> = .constant(false)
    ) {
        self.name = name
        self.complexity = complexity
        self.exercises = exercises
        self._newLesson = newLesson
    }
    func toggleNewLesson() {
        newLesson.toggle()
    }
    init(_ lesson: Lesson, newLesson: Binding<Bool>) {
        self.name = lesson.name
        self.complexity = lesson.complexity
        self.exercises = lesson.exercises
        self._newLesson = newLesson
    }
    var name: String
    var complexity: KnowledgeLevel
    var exercises: [any Exercise]
    @Binding var newLesson: Bool
    @EnvironmentObject var course: Course
}
enum ExerciseType {
    case Crossword
    case WordInsertionWithAnswerOptions
    case WordInsertion
    case Listening
    case Reading
    case Speaking
    case WordCards
    case Learning
}

protocol Exercise: Identifiable, View {
    var id: Int { get }
    var complexity: Int { get set }
    var languageFrom: LanguageFrom { get }
    var languageTo: LanguageTo { get }
    var type: ExerciseType { get }
    var exerciseIndex: Int { get }
    associatedtype Content: View
    var body: Content { get }

}

struct WordCards: Exercise {
    var id: Int
    var complexity: Int
    var languageFrom: LanguageFrom
    var languageTo: LanguageTo
    var type: ExerciseType = .WordCards
    @Binding var exerciseIndex: Int
    @State var currentCardStack: [Card] = Array()
    @State var showTranslate: Bool = false
    @State var currentCard: Card? = nil
    var cards: [Card]
    @State var newCardNeeded = true
    init(
        id: Int, complexity: Int,
        languageFrom: LanguageFrom, languageTo: LanguageTo,
        exerciseIndex: Binding<Int> = .constant(0),
        cards: [Card], newCardNeeded: Bool = true
    ) {
        self.id = id
        self.complexity = complexity
        self.languageFrom = languageFrom
        self.languageTo = languageTo
        self._exerciseIndex = exerciseIndex
        self.cards = cards
        self.newCardNeeded = newCardNeeded
    }
    init(_ wordCards: WordCards, index: Binding<Int>) {
        self.id = wordCards.id
        self.complexity = wordCards.complexity
        self.languageFrom = wordCards.languageFrom
        self.languageTo = wordCards.languageTo
        self._exerciseIndex = index
        self.cards = wordCards.cards
        self.newCardNeeded = wordCards.newCardNeeded
    }
    enum Condition {
        case KnownWord
        case InProgressWord
        case NewWord
    }

    struct Card {
        var wordFrom: String
        var wordTo: String
        var conditionType: Condition = .NewWord
    }
}
struct CrosswordCell:Codable {
    var isBlocked: Bool
    var isGuessed: Bool
    var hint: String = ""
}
struct Crossword: Exercise {
    var id: Int
    var complexity: Int
    var languageFrom: LanguageFrom
    var languageTo: LanguageTo
    @Binding var exerciseIndex: Int
    var type: ExerciseType = ExerciseType.Crossword
    var correctAnswers: [[String]]
    var crossword: [[CrosswordCell]]
    var hints: [String]
    init(
        id: Int, complexity: Int,
        languageFrom: LanguageFrom, languageTo: LanguageTo,
        exerciseIndex: Binding<Int> = .constant(0),
        correctAnswers: [[String]],
        crossword: [[CrosswordCell]],
        hints: [String] = Array()
    ) {
        self.id = id
        self.complexity = complexity
        self.languageFrom = languageFrom
        self.languageTo = languageTo
        self._exerciseIndex = exerciseIndex
        self.correctAnswers = correctAnswers
        self.crossword = crossword
        self.hints = hints
    }
    init(_ crossword: Crossword, index: Binding<Int>) {
        self.id = crossword.id
        self.complexity = crossword.complexity
        self.languageFrom = crossword.languageFrom
        self.languageTo = crossword.languageTo
        self._exerciseIndex = index
        self.correctAnswers = crossword.correctAnswers
        self.crossword = crossword.crossword
        self.hints = crossword.hints
    }
}
struct WordInsertionWithAnswerOptions: Exercise {
    var id: Int
    var complexity: Int
    var languageFrom: LanguageFrom
    var languageTo: LanguageTo
    var type: ExerciseType = ExerciseType
        .WordInsertionWithAnswerOptions
    @Binding var exerciseIndex: Int
    var descriptionLeft: String
    var descriptionRight: String
    var correctWord: String
    var answersOptions: [String]
    init(
        id: Int, complexity: Int,
        languageFrom: LanguageFrom, languageTo: LanguageTo,
        exerciseIndex: Binding<Int> = .constant(0),
        descriptionLeft: String,
        descriptionRight: String,
        correctWord: String, answersOptions: [String]
    ) {
        self.id = id
        self.complexity = complexity
        self.languageFrom = languageFrom
        self.languageTo = languageTo
        self._exerciseIndex = exerciseIndex
        self.descriptionLeft = descriptionLeft
        self.descriptionRight = descriptionRight
        self.correctWord = correctWord
        self.answersOptions = answersOptions
    }
    init(
        _ wordInsertion: WordInsertionWithAnswerOptions,
        index: Binding<Int>
    ) {
        self.id = wordInsertion.id
        self.complexity = wordInsertion.complexity
        self.languageFrom = wordInsertion.languageFrom
        self.languageTo = wordInsertion.languageTo
        self._exerciseIndex = index
        self.descriptionLeft = wordInsertion.descriptionLeft
        self.descriptionRight =
            wordInsertion.descriptionRight
        self.correctWord = wordInsertion.correctWord
        self.answersOptions = wordInsertion.answersOptions
    }
}
struct WordInsertion: Exercise {
    var id: Int
    var complexity: Int
    var languageFrom: LanguageFrom
    var languageTo: LanguageTo
    @Binding var exerciseIndex: Int
    var type: ExerciseType = ExerciseType.WordInsertion
    var descriptionLeft: String
    var descriptionRight: String
    var correctWord: String
    init(
        _ wordInsertion: WordInsertion, index: Binding<Int>
    ) {
        self.id = wordInsertion.id
        self.complexity = wordInsertion.complexity
        self.languageFrom = wordInsertion.languageFrom
        self.languageTo = wordInsertion.languageTo
        self._exerciseIndex = index
        self.descriptionLeft = wordInsertion.descriptionLeft
        self.descriptionRight =
            wordInsertion.descriptionRight
        self.correctWord = wordInsertion.correctWord
    }
    init(
        id: Int, complexity: Int,
        languageFrom: LanguageFrom, languageTo: LanguageTo,
        exerciseIndex: Binding<Int> = .constant(0),
        descriptionLeft: String,
        descriptionRight: String,
        correctWord: String
    ) {
        self.id = id
        self.complexity = complexity
        self.languageFrom = languageFrom
        self.languageTo = languageTo
        self._exerciseIndex = exerciseIndex
        self.descriptionLeft = descriptionLeft
        self.descriptionRight = descriptionRight
        self.correctWord = correctWord
    }
    @State var insertedWord: String = ""
    @State var isSubmitted: Bool? = nil

}

struct Reading: Exercise {

    struct TrueFalseExercise: Identifiable {
        var id: Int
        var description: String
        var correctAnswer: Bool
        @State var answer: Bool? = nil
        init(
            id: Int, description: String,
            correctAnswer: Bool
        ) {
            self.id = id
            self.description = description
            self.correctAnswer = correctAnswer
            self.answer = nil
        }
    }

    var id: Int
    var complexity: Int
    var languageFrom: LanguageFrom
    var languageTo: LanguageTo
    @Binding var exerciseIndex: Int
    var type: ExerciseType = ExerciseType.WordInsertion
    var name: String
    var text: String
    var exercises: [TrueFalseExercise]

    init(
        id: Int, complexity: Int,
        languageFrom: LanguageFrom, languageTo: LanguageTo,
        type: ExerciseType = .Reading, name: String,
        text: String, exercises: [TrueFalseExercise],
        exerciseIndex: Binding<Int> = .constant(0)
    ) {
        self.id = id
        self.complexity = complexity
        self.languageFrom = languageFrom
        self.languageTo = languageTo
        self.type = type
        self.name = name
        self.text = text
        self.exercises = exercises
        self._exerciseIndex = exerciseIndex
    }
    init(_ exercise:Reading,index:Binding<Int>){
        self.id = exercise.id
        self.complexity = exercise.complexity
        self.languageFrom = exercise.languageFrom
        self.languageTo = exercise.languageTo
        self.type = exercise.type
        self.name = exercise.name
        self.text = exercise.text
        self.exercises = exercise.exercises
        self._exerciseIndex = index
    }
}

struct SpeakingExercise: Exercise {
    var id: Int
    var complexity: Int
    var languageFrom: LanguageFrom
    var languageTo: LanguageTo
    @Binding var exerciseIndex: Int
    var type: ExerciseType = .Speaking
    var correctAnswer: String
    init(
        id: Int, complexity: Int,
        languageFrom: LanguageFrom, languageTo: LanguageTo,
        exerciseIndex: Binding<Int> = .constant(0),
        correctAnswer: String
    ) {
        self.id = id
        self.complexity = complexity
        self.languageFrom = languageFrom
        self.languageTo = languageTo
        self._exerciseIndex = exerciseIndex
        self.correctAnswer = correctAnswer
    }
    init(_ speaking: SpeakingExercise, index: Binding<Int>) {
        self.id = speaking.id
        self.complexity = speaking.complexity
        self.languageFrom = speaking.languageFrom
        self.languageTo = speaking.languageTo
        self._exerciseIndex = index
        self.correctAnswer = speaking.correctAnswer
    }
}
struct Learning: Exercise {
    var id: Int
    var complexity: Int
    var languageFrom: LanguageFrom
    var languageTo: LanguageTo
    @Binding var exerciseIndex: Int
    var type: ExerciseType = .Learning
    var markdownText: String
    init(
        id: Int, complexity: Int,
        languageFrom: LanguageFrom, languageTo: LanguageTo,
        exerciseIndex: Binding<Int> = .constant(0),
        markdownText: String
    ) {
        self.id = id
        self.complexity = complexity
        self.languageFrom = languageFrom
        self.languageTo = languageTo
        self._exerciseIndex = exerciseIndex
        self.markdownText = markdownText
    }
    init(_ learning: Learning, index: Binding<Int>) {
        self.id = learning.id
        self.complexity = learning.complexity
        self.languageTo = learning.languageTo
        self.languageFrom = learning.languageFrom
        self._exerciseIndex = index
        self.markdownText = learning.markdownText
    }
}
