//
//  ContentView.swift
//  iQuiz
//
//  Created by Ahmed Ghaddah on 5/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = QuizViewModel()  // Initialize ViewModel
    @State private var showSettings = false  // Control display of settings view

    var body: some View {
        NavigationView {
            List(viewModel.topics, id: \.id) { topic in
                NavigationLink(destination: QuizView(viewModel: QuizViewModel(questions: topic.questions))) {

                    HStack {
                        Image(systemName: topic.iconName ?? "questionmark.circle")
                            .foregroundColor(.blue)
                        Text(topic.title)
                    }
                }
            }
            .navigationTitle("Quiz Topics")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Settings") {
                        showSettings = true
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView(viewModel: viewModel, showSettings: $showSettings)
            }
        }
    }
}
#Preview {
    ContentView()
}
