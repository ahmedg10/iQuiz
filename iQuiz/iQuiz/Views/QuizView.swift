//
//  QuizView.swift
//  iQuiz
//
//  Created by Ahmed Ghaddah on 5/13/24.
//

import Foundation
import SwiftUI

struct QuizView: View {
    @StateObject var viewModel: QuizViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.quizFinished {
                    FinishedView(viewModel: viewModel)
                } else {
                    QuestionView(viewModel: viewModel)
                }
            }
            .navigationBarTitle("Quiz", displayMode: .inline)
            .navigationBarItems(leading: Button("Back") {
                // Pop to ContentView or root, assuming this view is pushed from ContentView
                viewModel.resetQuiz()
            })
        }
    }
}
