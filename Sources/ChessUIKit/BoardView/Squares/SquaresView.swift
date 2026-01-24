//
//  SquaresView.swift
//  TestChess
//
//  Created by MacBook Pro13 on 25.06.2024.
//

import UIKit

final class SquaresView: UIView {
    var configuration: SquareConfiguration {
        didSet { update() }
    }
                          
    private var squaresView: [SquareView] = []
    
    init(configuration: SquareConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        configuration = .default
        
        super.init(coder: coder)
        
        setup()
    }
    
    func getSquare(at coordinates: Coordinates) -> SquareView {
        squaresView[coordinates.x * 8 + coordinates.y]
    }
    
    func highlight(square: Square) {
        let squareView = squaresView[square.coordinates.x * 8 + square.coordinates.y]
        squareView.highlight(color: square.color)
    }
    
    func highlight(squares: [Square], clearPrevious: Bool = true) {
        if clearPrevious {
            unhighlightAllSquares()
        }
        
        squares.forEach {
            let squareView = squaresView[$0.coordinates.x * 8 + $0.coordinates.y]
            squareView.highlight(color: $0.color)
        }
    }
    
     func unhighlightAllSquares() {
        for squareView in squaresView where squareView.isHighlighted {
            squareView.unhighlight()
        }
    }
    
    private func setup() {
        for row in 0...7 {
            for column in 0...7 {
                let isWhite = row % 2 == column % 2
                let squareColor = isWhite ? configuration.whiteColor : configuration.blackColor
                let view = SquareView(squareColor: squareColor)
                squaresView.append(view)
                
                addSubview(view)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
        setFrame()
    }
    
    private func setFrame() {
        for row in 0...7 {
            for column in 0...7 {
                let frame = frame(x: CGFloat(row), y: CGFloat(column), size: squareSize)
                squaresView[row * 8 + column].frame = frame
            }
        }
    }
    
    private func update() {

    }
    
    private func loop(squareVie: @escaping (SquareView) -> Void) {
        for row in 0...7 {
            for column in 0...7 {
                let squareView = squaresView[row * 8 + column]
                
                squareVie(squareView)
            }
        }
    }
}

