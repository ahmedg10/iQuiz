//
//  QuestionView.swift
//  iQuiz
//
//  Created by Ahmed Ghaddah on 5/13/24.
//

import Foundation
import SwiftUI
struct QuestionView: View {
    @ObservedObject var viewModel: QuizViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.currentQuestion.text)
                .font(.title)
                .padding()

            // Display options as buttons
            ForEach(viewModel.currentQuestion.answers, id: \.self) { option in
                Button(action: {
                    viewModel.selectedAnswer = option  // Update selected answer on tap
                }) {
                    Text(option)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(viewModel.selectedAnswer == option ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }

            // Submit button to manually submit the answer
            Button("Submit") {
                if let answer = viewModel.selectedAnswer {
                    viewModel.submitAnswer(answer)
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(viewModel.selectedAnswer == nil)  // Disable button if no answer is selected

            // Result display after submission
            if viewModel.showResult {
                Text(viewModel.isAnswerCorrect! ? "Correct!" : "Incorrect!")
                    .foregroundColor(viewModel.isAnswerCorrect! ? .green : .red)
                Button("Next") {
                    viewModel.nextQuestion()
                }
                .padding()
            }
            GestureHintView()  // Optional: View to hint at gesture use
        }
        .padding()
        .gesture(DragGesture().onEnded(handleSwipe))
    }

    func handleSwipe(_ gesture: DragGesture.Value) {
        let horizontalSwipe = gesture.translation.width
        if horizontalSwipe > 100 {
            // Right swipe acts like pressing the Submit button
            if let answer = viewModel.selectedAnswer, !viewModel.showResult {
                viewModel.submitAnswer(answer)
            } else if viewModel.showResult {
                viewModel.nextQuestion()
            }
        } else if horizontalSwipe < -100 {
            // Left swipe to reset the quiz
            viewModel.resetQuiz()
        }
    }
}
