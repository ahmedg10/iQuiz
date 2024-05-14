//
//  ContentView.swift
//  iQuiz
//
//  Created by Ahmed Ghaddah on 5/12/24.
//

import SwiftUI

struct ContentView: View {
    let topics: [QuizTopic] = [
         QuizTopic(
             title: "Mathematics",
             description: "Challenge your math skills.",
             questions: [
                 QuizQuestion(
                     question: "What is 2 + 2?",
                     options: ["3", "4", "5", "6"],
                     correctAnswer: "4"
                 ),
                 QuizQuestion(
                     question: "What is the square root of 16?",
                     options: ["3", "4", "5", "8"],
                     correctAnswer: "4"
                 )
             ],
             iconName: "plusminus.circle"
         ),
         QuizTopic(
             title: "Marvel Super Heroes",
             description: "Explore Marvel's universe.",
             questions: [
                 QuizQuestion(
                     question: "Who is Tony Stark's superhero alter ego?",
                     options: ["Iron Man", "Captain America", "Thor", "Hulk"],
                     correctAnswer: "Iron Man"
                 ),
                 QuizQuestion(
                     question: "What is Thor's hammer called?",
                     options: ["Mjolnir", "Stormbreaker", "Aegis", "Excalibur"],
                     correctAnswer: "Mjolnir"
                 )
             ],
             iconName: "sparkles"
         ),
         QuizTopic(
             title: "Science",
             description: "Discover the wonders of science.",
             questions: [
                 QuizQuestion(
                     question: "What is the chemical formula for water?",
                     options: ["H2O", "CO2", "O2", "N2"],
                     correctAnswer: "H2O"
                 ),
                 QuizQuestion(
                     question: "What force keeps us on the ground?",
                     options: ["Gravity", "Magnetism", "Friction", "Inertia"],
                     correctAnswer: "Gravity"
                 )
             ],
             iconName: "thermometer.sun"
         )
     ]
    
    @State private var showSettingAlert = false

    var body: some View {
           NavigationView {
               VStack {
                   Spacer()
                   List(topics) { topic in
                       NavigationLink(destination: QuizView(viewModel: QuizViewModel(questions: topic.questions))) {
                           TopicRow(topic: topic)
                       }
                   }
                   .listStyle(PlainListStyle()) // Applying plain list style which allows background customization
                   .background(Color.white) // Setting background color here
                   Spacer()
               }
               .background(Color.white) // Ensuring the background of the VStack is also white
               .navigationTitle("Quiz Topics")
               .toolbar{
                   ToolbarItem(placement: .navigationBarTrailing) {
                       Button(action: {
                           showSettingAlert = true
                       }, label: {
                           Image(systemName: "gear")
                       })
                   }
               }
               .alert(isPresented:$showSettingAlert, content: {
                   Alert(title: Text("Settings"), message: Text("Click button for setting"), dismissButton: .default(Text("OK")))
               })
           }
           .background(Color.white) // Making sure the NavigationView's background is white as well
       }
   }

#Preview {
    ContentView()
}
