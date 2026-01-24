//
//  NonePieceAnimator.swift
//  ChessUIKit
//
//  Created by MacBook Pro13 on 04.07.2025.
//


struct NonePieceAnimator: PieceAnimationProvider {
    func animate(animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        
        completion?(true)
    }
}