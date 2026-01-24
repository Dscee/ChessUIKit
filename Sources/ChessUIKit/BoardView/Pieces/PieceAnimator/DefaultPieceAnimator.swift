//
//  DefaultPieceAnimator.swift
//  TestChess
//
//  Created by MacBook Pro13 on 20.08.2024.
//

import UIKit

public struct DefaultPieceAnimator: PieceAnimationProvider {
    private let duration: TimeInterval
    
    public init(duration: TimeInterval = 0.2) {
        self.duration = duration
    }
    
    public func animate(animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        UIView.animate(
            withDuration: duration,
            animations: animations,
            completion: completion
        )
    }
}
