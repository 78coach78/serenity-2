//
//  File.swift
//  Serenity
//
//  Created by Roland Ramseier on 03.05.2026.
//

import Foundation
import SwiftUI

enum Mood: Int, Codable, CaseIterable {
    case veryGood = 5;
    case good = 4;
    case neutral = 3;
    case low = 1;
    case veryLow = 0
    
    var label: String {
        switch self {
        case .veryGood: return "Very Good"
        case .good: return "Good"
        case .neutral: return "Okay"
        case .low: return "Low"
        case .veryLow: return "Very Low"
        }
    }

    var color: Color {
        switch self {
        case .veryGood: return Color.green
        case .good: return Color("SeaGreen")
        case .neutral: return Color.gray
        case .low: return Color.orange
        case .veryLow: return Color.red
        }
    }

    var icon: String {
        switch self {
        case .veryGood: return "face.smiling.fill"
        case .good: return "smiley"
        case .neutral: return "face.neutral"
        case .low: return "face.dashed"
        case .veryLow: return "frown"
        }
    }

}

struct CheckIn: Identifiable, Codable {
    var id: UUID = UUID()
    var date: Date = Date()
    var mood: Mood
    var gratitude: String
    var memory: String?
}

struct Quote: Identifiable {
    let id = UUID()
    let text: String
    let author: String?
}
