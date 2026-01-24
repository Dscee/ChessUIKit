//
//  СhessArrowViews.swift
//  TestChess
//
//  Created by MacBook Pro13 on 25.06.2024.
//

import UIKit

final class ArrowsView: UIView {
    private var arrowViews: [Arrow: ArrowView] = [:]
        
    func add(arrows: [Arrow]) {
        arrows.forEach {
            let startPoint = getSquareCenter(for: $0.from)
            let endPoint = getSquareCenter(for: $0.to)
            
            let arrowView = ArrowView(
                startPoint: startPoint,
                endPoint: endPoint,
                color: $0.color
            )
            
            arrowViews[$0] = arrowView
            
            addSubview(arrowView)
        }
    }
    
    func removeAllArrows() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func getSquareCenter(for coordinates: Coordinates) -> CGPoint {
        let squareCenter = squareSize.height / 2
        let x = squareCenter + (squareSize.width * CGFloat(coordinates.x))
        let y = squareCenter + (squareSize.width * CGFloat((coordinates.y)))
        
        return CGPoint(x: x, y: y)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        subviews.forEach { $0.frame = self.bounds }
    }
}


