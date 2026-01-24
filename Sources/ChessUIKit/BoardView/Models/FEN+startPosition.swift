//
//  File.swift
//  ChessUIKit
//
//  Created by MacBook Pro13 on 04.07.2025.
//

import Foundation

public extension FEN {
    static var startPosition: FEN {
        try! FEN(fromString: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
    }
}
