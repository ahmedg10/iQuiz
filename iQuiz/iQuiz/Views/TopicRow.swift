//
//  TopicRow.swift
//  iQuiz
//
//  Created by Ahmed Ghaddah on 5/12/24.
//

import Foundation
import SwiftUI

struct TopicRow: View {
    var topic: QuizTopic //this is passing a parameter pretty much
    
    var body: some View {
            HStack {
                Image(systemName: topic.iconName) // Use the icon name from the topic
                    .imageScale(.large) // Controls the size of the image
                    .foregroundColor(.blue) // Set the color of the icon
                
                VStack(alignment: .leading) {
                    Text(topic.title)
                        .font(.headline)
                    Text(topic.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding() // Padding around the entire horizontal stack
        }
}

#Preview{
    TopicRow(topic: QuizTopic(title: "Mathematics", description: "Challenge your math skills.", questions: [], iconName: "plusminus.circle"))
               .previewLayout(.sizeThatFits)
               .padding()
}
