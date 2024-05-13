//
//  QuizTopics.swift
//  iQuiz
//
//  Created by Ahmed Ghaddah on 5/12/24.
//

import Foundation
import SwiftUI

struct QuizTopic: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let questions: [QuizQuestion]
    let iconName: String 
}

struct QuizQuestion: Identifiable {
    let id = UUID()
    let question: String
    let options: [String]
    let correctAnswer: String
}
