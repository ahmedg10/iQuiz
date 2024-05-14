//
//  GestureView.swift
//  iQuiz
//
//  Created by Ahmed Ghaddah on 5/13/24.
//

import Foundation
import SwiftUI

struct GestureHintView: View {
    var body: some View {
        VStack {
            Text("Swipe Right to Submit/Next")
                .font(.caption)
                .padding(.top)
            Text("Swipe Left to Go Back")
                .font(.caption)
                .padding(.bottom)
        }
        .foregroundColor(.gray)
    }
}

