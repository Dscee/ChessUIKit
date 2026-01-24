//
//  К.swift
//  ChessUIKit
//
//  Created by MacBook Pro13 on 04.07.2025.
//


extension PieceAnimationProvider {
    static var `default`: PieceAnimationProvider {
        DefaultPieceAnimator()
    }
    
    static var none: NonePieceAnimator {
        NonePieceAnimator()
    }
}