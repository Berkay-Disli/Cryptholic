//
//  ChartColorRanges.swift
//  Cryptholic
//
//  Created by Berkay Disli on 8.08.2022.
//

import Foundation
import SwiftUI

enum ChartColors: String, CaseIterable {
    case red, black, white, orange, yellow, green, blue, purple
    
    var title: String {
        switch self {
        case .red:
            return "🟥 Red"
        case .black:
            return "⬛️ Black"
        case .white:
            return "⬜️ White"
        case .orange:
            return "🟧 Orange"
        case .yellow:
            return "🟨 Yellow"
        case .green:
            return "🟩 Green"
        case .blue:
            return "🟦 Blue"
        case .purple:
            return "🟪 Purple"
        }
    }
    
    var color: Color {
        switch self {
        case .red:
            return .red
        case .black:
            return .black
        case .white:
            return .white
        case .orange:
            return .orange
        case .yellow:
            return .yellow
        case .green:
            return .green
        case .blue:
            return .blue
        case .purple:
            return .purple
        }
    }
}
