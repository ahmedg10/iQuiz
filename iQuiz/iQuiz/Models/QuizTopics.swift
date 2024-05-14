//
//  QuizTopics.swift
//  iQuiz
//
//  Created by Ahmed Ghaddah on 5/12/24.
//

import Foundation
import SwiftUI

struct QuizTopic: Identifiable, Decodable {
    var id: UUID { UUID() }  // This provides a unique ID but does not decode from JSON
    let title: String
    let desc: String
    let questions: [QuizQuestion]
    var iconName: String?  // Change this to var if you want to modify it later

}

struct QuizQuestion: Identifiable, Decodable {
    var id: UUID { UUID() }  // Provides a unique ID for each question
    let text: String
    let answer: String  // This should be an index or identifier
    let answers: [String]
}
