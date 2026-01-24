//
//  SquareImageView.swift
//  TestChess
//
//  Created by MacBook Pro13 on 18.09.2024.
//

import UIKit

final class SquareView: UIView {
    private let highlightedSquareView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var isHighlighted: Bool {
        highlightedSquareView.backgroundColor != .clear
    }
    
    var squareColor: UIColor {
        didSet {
            imageView.image = UIImage.withColor(squareColor)
        }
    }
    
    init(squareColor: UIColor) {
        self.squareColor = squareColor
        super.init(frame: .zero)
        imageView.image = UIImage.withColor(squareColor)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.squareColor = .clear
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        addSubview(imageView)
        addSubview(highlightedSquareView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = bounds
        highlightedSquareView.frame = bounds
    }
    
    func highlight(color: UIColor) {
        highlightedSquareView.backgroundColor = color
    }
    
    func unhighlight() {
        highlightedSquareView.backgroundColor = .clear
    }
}
