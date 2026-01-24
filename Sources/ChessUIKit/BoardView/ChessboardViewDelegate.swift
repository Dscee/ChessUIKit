//
//  ChessboardViewDelegate.swift
//  TestChess
//
//  Created by MacBook Pro13 on 03.08.2024.
//

import Foundation

@MainActor
public protocol ChessboardViewDelegate: AnyObject {
    func boardView(_ boardView: ChessboardView, didTap coordinates: Coordinates)
    func boardView(_ boardView: ChessboardView, canPieceMakeMove move: Move) -> Bool
    func boardView(_ boardView: ChessboardView, proposedMove move: Move)
    func boardView(_ boardView: ChessboardView, canDragPieceAt coordinates: Coordinates) -> Bool
    func willDragPieceOutsideBoard(_ boardView: ChessboardView)
    func didFinishMoveAnimation(_ boardView: ChessboardView)
    func willFinishMoveAnimation(_ boardView: ChessboardView)
    func didEndDraggingPiece(_ boardView: ChessboardView, move: Move)
    func didStartMoveAnimation(_ boardView: ChessboardView, move: Move)
    func didFinishMoveAnimation()
    func didSelectPromotedPiece(promotedPiece: PromotedPiece)
    func cancelPromotion()
}

public extension ChessboardViewDelegate {
    public func willDragPieceOutsideBoard(_ boardView: ChessboardView) {}
    public func didEndDraggingPiece(_ boardView: ChessboardView, move: Move) {}
    public func didStartMoveAnimation(_ boardView: ChessboardView, move: Move) {}
    public func didFinishMoveAnimation() {}
}
