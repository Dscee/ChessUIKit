//
//  Piece.swift
//  TestChess
//
//  Created by MacBook Pro13 on 03.08.2024.
//

import UIKit

public struct Piece: Hashable {
    public let coordinates: Coordinates
    public let image: UIImage
    
    public init(coordinates: Coordinates, image: UIImage) {
        self.coordinates = coordinates
        self.image = image
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(coordinates)
    }
}
