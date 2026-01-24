//
//  FENParser.swift
//  ChessUIKit
//
//  Created by MacBook Pro13 on 04.07.2025.
//

import Foundation

final class FENParser {
    static func render(fen: FEN) -> [Piece] {
        let pieceSymbols: [Character: String] = [
            "p": "pawn", "r": "rook", "n": "knight",
            "b": "bishop", "q": "queen", "k": "king"
        ]
        
        var pieces: [Piece] = []
        let ranks = fen.position.split(separator: "/")
        
        for (rankIndex, rankString) in ranks.enumerated() {
            var file = 0
            for char in rankString {
                if let digit = char.wholeNumberValue {
                    file += digit
                } else {
                    let lowerChar = char.lowercased().first!
                    guard let typeRaw = pieceSymbols[lowerChar],
                          let kind = Piece.PieceKind(rawValue: typeRaw) else { continue }
                    let color: Piece.Color = char.isUppercase ? .white : .black
                    let fileChar = Character(UnicodeScalar(97 + file)!) // 'a' = 97
                    let rankNum = 8 - rankIndex
                    let coordinateCase = Coordinates(rawValue: "\(fileChar)\(rankNum)")!
                    
                    let piece = Piece(coordinates: coordinateCase, kind: kind, color: color)
                    
                    pieces.append(piece)
                    file += 1
                }
            }
        }
        
        return pieces
    }
}


