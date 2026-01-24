//
//  Move.swift
//  TestChess
//
//  Created by MacBook Pro13 on 03.08.2024.
//

import UIKit

public struct Move {
    public let from: Coordinates
    public let to: Coordinates
    public let replaceImage: UIImage?
    
    public init?(
        from: Coordinates,
        to: Coordinates,
        replaceImage: UIImage? = nil
    ) {
        guard from != to else { return nil }
        self.from = from
        self.to = to
        self.replaceImage = replaceImage
    }
    
    public init(uci: UCIMove) {
        self.from = uci.from
        self.to = uci.to
        self.replaceImage = nil
    }
}

 extension Move: CustomStringConvertible {
     public var description: String {
         "\(from.sanMove)\(to.sanMove)"
    }
}

extension Move: Equatable {
    
}

