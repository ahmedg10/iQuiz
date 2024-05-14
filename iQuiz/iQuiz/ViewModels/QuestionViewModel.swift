//
//  QuestionViewModel.swift
//  The Interactions of the Quiz is held here, this is the controller, that holds the sepration of concern
//

import Foundation
import SwiftUI


class QuizViewModel: ObservableObject {
    @Published var currQuestionIndex = 0
    @Published var isAnswerCorrect: Bool?
    @Published var score = 0
    @Published var showResult = false
    @Published var quizFinished = false
    @Published var selectedAnswer: String?
    @Published var isErrorPresented = false
    @Published var errorMessage = ""
    @Published var showSettings = false
    @Published var questions: [QuizQuestion] = []
    @Published var topics: [QuizTopic] = []
    @Published var currentURL: String {
        didSet {
            UserDefaults.standard.set(currentURL, forKey: "QuizDataURL")
            fetchQuestions(urlString: currentURL)
        }
    }

    init(questions: [QuizQuestion] = []) {
            self.questions = questions
            if questions.isEmpty {
                self.currentURL = UserDefaults.standard.string(forKey: "QuizDataURL") ?? "https://tednewardsandbox.site44.com/questions.json"
                fetchQuestions(urlString: currentURL)
            } else {
                // If questions are provided, assume the quiz can start immediately
                self.currentURL = ""
            }
        }

    func fetchQuestions(urlString: String) {
        NetworkManager.shared.downloadData(from: urlString) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.decodeQuizData(data)
                case .failure(let error):
                    self?.errorMessage = "Error fetching questions: \(error.localizedDescription)"
                    self?.isErrorPresented = true
                }
            }
        }
    }

    private func decodeQuizData(_ data: Data) {
        do {
            var fetchedTopics = try JSONDecoder().decode([QuizTopic].self, from: data)
            // Assign random icons if not from JSON
            fetchedTopics = fetchedTopics.map { topic in
                var updatedTopic = topic
                updatedTopic.iconName = updatedTopic.iconName ?? randomIconName()
                return updatedTopic
            }
            self.topics = fetchedTopics
            self.questions = topics.flatMap { $0.questions }
        } catch {
            errorMessage = "Failed to decode quiz data: \(error.localizedDescription)"
            isErrorPresented = true
        }
    }

    private func randomIconName() -> String {
        let icons = ["plusminus.circle", "sparkles", "flame", "leaf.arrow.triangle.circlepath"]
        return icons.randomElement() ?? "circle"
    }
    
    var currentQuestion : QuizQuestion  {
        questions[currQuestionIndex]
    }
    
    func submitAnswer(_ answer: String) {
        selectedAnswer = answer  // Store the answer chosen by the user

        // Convert the correct answer index from String to Int (assuming zero-based indexing from JSON)
        if let correctAnswerIndex = Int(currentQuestion.answer),
           let indexOfSelectedAnswer = currentQuestion.answers.firstIndex(of: answer),
           correctAnswerIndex == indexOfSelectedAnswer {
            isAnswerCorrect = true
            score += 1  // Increment score if the answer is correct
        } else {
            isAnswerCorrect = false
        }

        showResult = true  // Update the view to show the result
    }

        func nextQuestion() {
            if currQuestionIndex < questions.count - 1 {
                currQuestionIndex += 1
                isAnswerCorrect = nil
                showResult = false
                selectedAnswer = nil  // Reset for the next question

            } else {
                quizFinished = true  // Indicate that the quiz is completed
            }
        }
    
    func resetQuiz() {
            currQuestionIndex = 0
            score = 0
        selectedAnswer = nil

            isAnswerCorrect = nil
            showResult = false
            quizFinished = false
        }
    
    
}

//class MainViewModel: ObservableObject {
//    @Published var quizViewModels: [QuizViewModel] = []
//
//    init() {
//        let topics: [QuizTopic] = [
//            QuizTopic(title: "Mathematics", description: "Challenge your math skills.", questions: [
//                QuizQuestion(question: "What is 2 + 2?", options: ["3", "4", "5", "6"], correctAnswer: "4"),
//                // More questions...
//            ]),
//            QuizTopic(title: "Marvel Super Heroes", description: "Explore Marvel's universe.", questions: [
//                QuizQuestion(question: "Who is Tony Stark?", options: ["Captain America", "Iron Man", "Thor", "Hulk"], correctAnswer: "Iron Man"),
//                // More questions...
//            ]),
//            QuizTopic(title: "Science", description: "Discover the wonders of science.", questions: [
//                QuizQuestion(question: "What is the chemical formula of water?", options: ["H2O", "CO2", "O2", "N2"], correctAnswer: "H2O"),
//                // More questions...
//            ])
//        ]
//        self.quizViewModels = topics.map { QuizViewModel(topic: $0) }
//    }
//}
//
//// ViewModel for the quiz
//class QuizViewModel: ObservableObject {
//    @Published var questions: [QuizQuestion] = []
//    @Published var currentQuestionIndex: Int = 0
//    @Published var selectedOption: String?
//    @Published var score: Int = 0
//    
//    init() {
//        loadQuestions()
//    }
//    
//    func loadQuestions() {
//        // Simulate loading data
//        questions = [
//            QuizQuestion(question: "What is 2 + 2?", options: ["2", "3", "4", "5"], correctAnswer: "4"),
//            QuizQuestion(question: "What color is the sky?", options: ["Blue", "Red", "Yellow", "Green"], correctAnswer: "Blue")
//        ]
//    }
//    
//    func submitAnswer() {
//        if let selected = selectedOption, selected == questions[currentQuestionIndex].correctAnswer {
//            score += 1
//        }
//        if currentQuestionIndex < questions.count - 1 {
//            currentQuestionIndex += 1
//            selectedOption = nil // Reset selected option
//        } else {
//            // Quiz is complete
//            print("Quiz Completed. Final score: \(score)")
//        }
//    }
//}
//
//// View that uses the ViewModel
//struct QuizView: View {
//    @StateObject var viewModel = QuizViewModel()
//    
//    var body: some View {
//        VStack {
//            Text(viewModel.questions[viewModel.currentQuestionIndex].question)
//            ForEach(viewModel.questions[viewModel.currentQuestionIndex].options,
