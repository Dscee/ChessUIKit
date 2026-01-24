//
//  PieceAnimationProvider.swift
//  TestChess
//
//  Created by MacBook Pro13 on 20.08.2024.
//

import Foundation

@MainActor
public protocol PieceAnimationProvider {
    func animate(animations: @escaping () -> Void, completion: ((Bool) -> Void)?)
}






