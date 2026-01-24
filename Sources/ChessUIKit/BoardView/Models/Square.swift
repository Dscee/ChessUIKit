//
//  Square.swift
//  TestChess
//
//  Created by MacBook Pro13 on 03.08.2024.
//

import UIKit

public struct Square: Hashable {
    let coordinates: Coordinates
    let color: UIColor
    
    public init(coordinates: Coordinates, color: UIColor) {
        self.coordinates = coordinates
        self.color = color
    }
}
