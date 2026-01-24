//
//  UIView+flipVertically.swift
//  TestChess
//
//  Created by MacBook Pro13 on 03.07.2025.
//

import UIKit

extension UIView {
    func flipVertically(_ bool: Bool) {
        transform = bool ? CGAffineTransform(rotationAngle: CGFloat.pi) : .identity
    }
}
