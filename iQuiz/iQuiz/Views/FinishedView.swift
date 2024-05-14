//
//  FinishedView.swift
//  iQuiz
//
//  Created by Ahmed Ghaddah on 5/13/24.
//

import Foundation
import SwiftUI

struct FinishedView: View {
    @ObservedObject var viewModel: QuizViewModel

    var body: some View {
        VStack {
            Text("Quiz Finished!")
                .font(.largeTitle)
            Text("Your score is \(viewModel.score) out of \(viewModel.questions.count)")
                .font(.title)
            Text(viewModel.score == viewModel.questions.count ? "Perfect!" : "Try Again!")
                .font(.headline)
            Button("Restart Quiz") {
                viewModel.resetQuiz()
            }
            .padding()
        }
        .gesture(DragGesture().onEnded { value in
            if value.translation.width > 100 {
                viewModel.resetQuiz() // Restart the quiz
            }
        })
    }
}
