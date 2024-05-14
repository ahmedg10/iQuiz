//
//  QuestionViewModel.swift
//  The Interactions of the Quiz is held here, this is the controller, that holds the sepration of concern
//

import Foundation
import SwiftUI


class QuizViewModel: ObservableObject {
    @Published var questions: [QuizQuestion]
    @Published var currQuestionIndex = 0
    @Published var isAnswerCorrect: Bool? = nil //nil because we aren't given if the answer is correct or not
    @Published var score = 0
    @Published var showResult = false
    @Published var quizFinished = false
    @Published var selectedAnswer: String? = nil  // Add this line

    
    init(questions: [QuizQuestion]){
        self.questions = questions
    }
    
    var currentQuestion : QuizQuestion  {
        questions[currQuestionIndex]
    }
    
    func submitAnswer(_ answer: String) {
            selectedAnswer = answer  // Ensure this is set when an answer is submitted

            isAnswerCorrect = answer == currentQuestion.correctAnswer
            if isAnswerCorrect == true {
                score += 1
            }
            showResult = true
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
