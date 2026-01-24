//
//  MoveIndicatorView.swift
//  TestChess
//
//  Created by MacBook Pro13 on 18.09.2024.
//

import UIKit

final class MoveIndicatorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        false
    }
    
    private func setup() {
        backgroundColor = UIColor.yellow
        alpha = 0.5
    }
}

