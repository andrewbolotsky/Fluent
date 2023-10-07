import Speech
import SwiftUI

private struct SpeakingView: View {
    @State private var isRecording = false
    @State private var recognizedText = ""
    @Binding var exerciseIndex: Int
    var correctAnswer: String
    @State private
        var recognizedTextWithoutPunctuationMarks: String =
            ""
    private var correctAnswerWithoutPunctuationMarks: String
    @State var isSubmitted = false
    var language: LanguageTo
    init(
        isRecording: Bool = false,
        recognizedText: String = "",
        exerciseIndex: Binding<Int>,
        correctAnswer: String, languageTo: LanguageTo
    ) {
        self.isRecording = isRecording
        self.recognizedText = recognizedText
        self._exerciseIndex = exerciseIndex
        self.correctAnswer = correctAnswer
        self.correctAnswerWithoutPunctuationMarks =
            self.correctAnswer
        self.language = languageTo
        self.correctAnswerWithoutPunctuationMarks.removeAll(
            where: {
                $0.isPunctuation || $0.isMathSymbol
                    || $0.isNewline
            })
    }
    var body: some View {
        if isSubmitted
            && recognizedTextWithoutPunctuationMarks
                .lowercased()
                == correctAnswerWithoutPunctuationMarks
                .lowercased()
        {
            showNextButton(exerciseIndex: $exerciseIndex)
        } else {
            VStack {
                Text(correctAnswer).font(.title)
                    .padding()
                Button(action: {
                    if isRecording {
                        stopRecording()
                    } else {
                        startRecording()
                    }
                }) {
                    Text(
                        isRecording
                            ? "Stop Recording"
                            : "Start Recording"
                    )
                    .font(.headline)
                    .padding()
                    .background(
                        isRecording
                            ? Color.blue : Color.gray
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                Text("You said:\(recognizedText)")
                    .padding()

                Button(action: {

                    isSubmitted = true
                    if recognizedTextWithoutPunctuationMarks
                        .lowercased()
                        != correctAnswerWithoutPunctuationMarks
                        .lowercased()
                    {
                        recognizedTextWithoutPunctuationMarks =
                            ""
                        recognizedText = ""
                    }
                }) {
                    Text("Submit")
                        .font(.subheadline)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

            }
        }
    }

    func startRecording() {
        guard
            let recognizer = SFSpeechRecognizer(
                locale: Locale(identifier: "en-US"))
        else {
            return
        }

        if !recognizer.isAvailable {
            return
        }

        SFSpeechRecognizer.requestAuthorization { status in
            switch status {
            case .authorized:
                do {
                    try self.startAudioSession()
                    self.isRecording = true

                    let recognitionRequest =
                        SFSpeechAudioBufferRecognitionRequest()
                    let inputNode = self.audioEngine
                        .inputNode

                    recognitionRequest
                        .shouldReportPartialResults = true

                    let recordingFormat =
                        inputNode.outputFormat(forBus: 0)
                    inputNode.installTap(
                        onBus: 0, bufferSize: 1024,
                        format: recordingFormat
                    ) {
                        buffer, _ in
                        recognitionRequest.append(buffer)
                    }

                    self.audioEngine.prepare()
                    try self.audioEngine.start()

                    recognizer.recognitionTask(
                        with: recognitionRequest
                    ) { result, error in
                        if let result = result {
                            self.recognizedText =
                                result.bestTranscription
                                .formattedString
                            recognizedTextWithoutPunctuationMarks =
                                recognizedText.lowercased()
                            recognizedTextWithoutPunctuationMarks
                                .removeAll(where: {
                                    $0.isPunctuation
                                        || $0.isMathSymbol
                                        || $0.isNewline
                                })
                        } else if let error = error {
                            print(
                                error.localizedDescription)
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }

            case .denied:
                print(
                    "User denied access to speech recognition"
                )

            case .restricted:
                print(
                    "Speech recognition restricted on this device"
                )

            case .notDetermined:
                print(
                    "Speech recognition not yet authorized")

            @unknown default:
                fatalError()
            }
        }
    }

    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        isRecording = false
    }

    func startAudioSession() throws {
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(
            .record, mode: .measurement,
            options: .duckOthers)
        try audioSession.setActive(
            true, options: .notifyOthersOnDeactivation)
    }

    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
}
extension SpeakingExercise: View {
    var body: some View {
        SpeakingView(
            exerciseIndex: $exerciseIndex,
            correctAnswer: correctAnswer,
            languageTo: languageTo)
    }
}
struct SpeakingView_Previews: PreviewProvider {
    static var previews: some View {
        SpeakingExercise(
            id: UUID().hashValue, complexity: 10,
            languageFrom: .russian, languageTo: .english,
            correctAnswer:
                "Some people think, but some people don't")
    }
}
