//
//  ArrowView.swift
//  TestChess
//
//  Created by MacBook Pro13 on 18.09.2024.
//

import UIKit

final class ArrowView: UIView {
    var startPoint: CGPoint = .zero
    var endPoint: CGPoint = .zero
    var fillColor: UIColor = UIColor.orange.withAlphaComponent(0.7)
    var strokeColor: UIColor = UIColor.orange.withAlphaComponent(0.7)
    
    init(
        startPoint: CGPoint,
        endPoint: CGPoint,
        color: UIColor
    ) {
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.fillColor = color
        self.strokeColor = color
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let arrow = UIBezierPath.arrow(
            from: startPoint,
            to: endPoint,
            tailWidth: 3,
            headWidth: 20,
            headLength: 19
        )
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = arrow.cgPath
        

        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.fillColor = fillColor.cgColor
        self.layer.addSublayer(shapeLayer)
    }
    
    func setup(startPoint: CGPoint,endPoint: CGPoint) {
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
}



fileprivate extension UIBezierPath {
    
    class func arrow(from start: CGPoint, to end: CGPoint, tailWidth: CGFloat, headWidth: CGFloat, headLength: CGFloat) -> Self {
        let length = hypot(end.x - start.x, end.y - start.y)
        let tailLength = length - headLength
        
        func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint { return CGPoint(x: x, y: y) }
        let points: [CGPoint] = [
            p(0, tailWidth / 2),
            p(tailLength, tailWidth / 2),
            p(tailLength, headWidth / 2),
            p(length, 0),
            p(tailLength, -headWidth / 2),
            p(tailLength, -tailWidth / 2),
            p(0, -tailWidth / 2)
        ]
        
        let cosine = (end.x - start.x) / length
        let sine = (end.y - start.y) / length
        let transform = CGAffineTransform(a: cosine, b: sine, c: -sine, d: cosine, tx: start.x, ty: start.y)
        
        let path = CGMutablePath()
        path.addLines(between: points, transform: transform )
        path.closeSubpath()
        
        return self.init(cgPath: path)
    }
}

