//
//  PieceKind.swift
//  ChessUIKit
//
//  Created by MacBook Pro13 on 04.07.2025.
//

import UIKit

public extension Piece {
    public enum PieceKind: String {
        case rook,knight,bishop,pawn,queen,king
    }
    
    public enum Color {
        case white, black
    }

    public init(
        coordinates: Coordinates,
        kind: PieceKind,
        color: Color
    ) {
        let image = UIImage(
            named: "S\(color == .white ? "W" : "B")_\(kind.rawValue.capitalized)",
            in: .module,
            compatibleWith: nil
        )!
        
        self.init(coordinates: coordinates, image: image)
    }
}
