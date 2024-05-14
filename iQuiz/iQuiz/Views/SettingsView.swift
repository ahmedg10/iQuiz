//
//  SettingsView.swift
//  iQuiz
//
//  Created by Ahmed Ghaddah on 5/13/24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: QuizViewModel
    @Binding var showSettings: Bool
    @State private var inputURL: String

    init(viewModel: QuizViewModel, showSettings: Binding<Bool>) {
        self.viewModel = viewModel
        self._showSettings = showSettings
        _inputURL = State(initialValue: viewModel.currentURL)
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Quiz Data URL", text: $inputURL)
                Button("Check Now") {
                    viewModel.currentURL = inputURL
                }
                if viewModel.isErrorPresented {
                    Text("Error: \(viewModel.errorMessage)").foregroundColor(.red)
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done") {
                showSettings = false
            })
        }
    }
}
