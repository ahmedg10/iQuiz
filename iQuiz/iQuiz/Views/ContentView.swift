//
//  ContentView.swift
//  iQuiz
//
//  Created by Ahmed Ghaddah on 5/12/24.
//

import SwiftUI

struct ContentView: View {
    let topics: [QuizTopic] = [
        QuizTopic(title: "Mathematics", description: "Challenge your math skills.", questions: [], iconName: "plusminus.circle"),
        QuizTopic(title: "Marvel Super Heroes", description: "Explore Marvel's universe.", questions: [], iconName: "sparkles"),
        QuizTopic(title: "Science", description: "Discover the wonders of science.", questions: [],iconName: "thermometer.sun")
    ]
    
    @State private var showSettingAlert = false

    var body: some View {
           NavigationView {
               VStack {
                   Spacer()
                   List(topics) { topic in
                       NavigationLink(destination: Text("Details for \(topic.title)")) {
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
