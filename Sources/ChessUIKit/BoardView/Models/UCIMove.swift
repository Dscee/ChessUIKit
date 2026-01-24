//
//  UCIMove.swift
//  Chess
//
//  Created by MacBook Pro13 on 04.07.2025.
//

import Foundation 

public struct UCIMove {
    let from: Coordinates
    let to: Coordinates
    let promotedPiece: PromotedPiece?
    
    public init?(uciFormat: String) {
        guard uciFormat.count == 4 || uciFormat.count == 5 else { return nil }

        let fromIndex = uciFormat.index(uciFormat.startIndex, offsetBy: 2)
        let fromString = String(uciFormat[..<fromIndex])
        let toString = String(uciFormat[fromIndex..<uciFormat.index(fromIndex, offsetBy: 2)])

        guard let from = Coordinates(rawValue: fromString),
              let to = Coordinates(rawValue: toString) else {
            return nil
        }

        self.from = from
        self.to = to
        self.promotedPiece = uciFormat.count == 5 ? .init(rawValue: String(uciFormat.last!)) : nil
    }
}
