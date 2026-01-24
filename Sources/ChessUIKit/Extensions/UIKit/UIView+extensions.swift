//
//  UIView+extensions.swift
//  TestChess
//
//  Created by MacBook Pro13 on 05.10.2024.
//

import UIKit

extension UIView {
    var squareSize: CGSize {
        let height = bounds.size.height / 8
        return CGSize(width: height, height: height)
    }
    
    func frame(x: CGFloat, y: CGFloat, size: CGSize) -> CGRect {
        let offset = CGPoint(x: CGFloat(x) * size.width, y: CGFloat(y) * size.height)
        return CGRect(origin: offset, size: size)
    }
}
