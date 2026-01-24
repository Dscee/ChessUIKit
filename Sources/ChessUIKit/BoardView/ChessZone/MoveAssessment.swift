//
//  MoveAssessment.swift
//  ChessUIKit
//
//  Created by MacBook Pro13 on 09.07.2025.
//

import UIKit

public enum MoveAssessment {
    case best
    case blunder
    case book
    case brilliant
    case fine
    case great
    case inaccuracy
    case missedVictory
    case mistake
    
    var image: UIImage {
        switch self {
        case .best: return .init(resource: .moveAssessmentBest)
        case .blunder: return .init(resource: .moveAssessmentBlunder)
        case .book: return .init(resource: .moveAssessmentBook)
        case .brilliant: return .init(resource: .moveAssessmentBrilliant)
        case .fine: return .init(resource: .moveAssessmentFine)
        case .great: return .init(resource: .moveAssessmentGreat)
        case .inaccuracy: return .init(resource: .moveAssessmentInaccuracy)
        case .missedVictory: return .init(resource: .moveAssessmentMissedVictory)
        case .mistake: return .init(resource: .moveAssessmentMistake)
        }
    }
}
