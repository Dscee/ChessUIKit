//
//  ChessMoveIndicatorsView.swift
//  TestChess
//
//  Created by MacBook Pro13 on 25.06.2024.
//

import UIKit

final class MoveIndicatorsView: UIView {
    var height: CGFloat = 20
    
    func display(indicators: [Indicator], shouldClearPreviousIndicators: Bool = true) {
        if shouldClearPreviousIndicators {
            removeAll()
        }
        
        add(indicators: indicators)
    }
    
    func removeAll() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func add(indicators: [Indicator]) {
        indicators.forEach {
            let view = MoveIndicatorView(frame: .init(origin: .zero, size: .init(width: 16, height: 16)))
            
            let coordinates = $0.coordinates
            
            let squareCenter = squareSize.height / 2
            let x = squareCenter + (squareSize.width * CGFloat(coordinates.x))
            let y = squareCenter + (squareSize.width * CGFloat((coordinates.y)))

            view.center = CGPoint(x: x, y: y)
            
            view.backgroundColor = $0.color
            
            addSubview(view)
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        false
    }
}





extension CGRect {
    static func square(origin: CGPoint = .zero, squareSize: CGFloat ) -> CGRect {
        CGRect(origin: .zero, size: CGSize(width: squareSize, height: squareSize))
    }
}


