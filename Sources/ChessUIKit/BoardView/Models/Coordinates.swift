//
//  Square.swift
//  TestChess
//
//  Created by MacBook Pro13 on 29.06.2024.
//

import Foundation

public struct Coordinates: Hashable {
    public let x: Int
    public let y: Int
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    public var file: String {
        ["a","b","c","d","e","f","g","h"][x]
    }
    
    public var rank: String {
        "\(8 - y)"
    }
    
    public var sanMove: String {
        "\(file)\(rank)"
    }    
}

public extension Coordinates {
   public init?(rawValue: String) {
        guard rawValue.count == 2,
              let fileChar = rawValue.first,
              let rankChar = rawValue.last,
              let x = ["a","b","c","d","e","f","g","h"].firstIndex(of: String(fileChar)),
              let rank = Int(String(rankChar)),
              (1...8).contains(rank)
        else {
            return nil
        }
        
        self.x = x
        self.y = 8 - rank
    }
}
