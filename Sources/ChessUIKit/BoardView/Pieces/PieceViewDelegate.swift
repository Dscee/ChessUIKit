//
//  PieceViewDelegate.swift
//  TestChess
//
//  Created by MacBook Pro13 on 18.09.2024.
//

import Foundation

@MainActor
protocol PieceViewDelegate: AnyObject {
    func didTap(_ pieceView: PieceView)
    func didStartDragging(_ pieceView: PieceView)
    func draggingPiece(_ pieceView: PieceView, to coordinates: Coordinates)
    func didEndDraggingPiece(_ pieceView: PieceView, to coordinates: Coordinates)
    func canDragPiece(_ pieceView: PieceView) -> Bool
    func canPieceMakeMove(_ pieceView: PieceView, move: Move) -> Bool
    func willDragPieceOutsideBoard(_ pieceView: PieceView)
}
