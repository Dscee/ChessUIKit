//
//  Arrow.swift
//  TestChess
//
//  Created by MacBook Pro13 on 03.08.2024.
//

import UIKit

public struct Arrow: Hashable {
    public let from: Coordinates
    public let to: Coordinates
    public let color: UIColor
    
    public init(from: Coordinates, to: Coordinates, color: UIColor) {
        self.from = from
        self.to = to
        self.color = color
    }
}
