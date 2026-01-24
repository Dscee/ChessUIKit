//
//  HighlightedPositionView.swift
//  TestChess
//
//  Created by MacBook Pro13 on 18.09.2024.
//

import UIKit

public class HighlightedPositionView: UIView {
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor(hex: "E9C336").withAlphaComponent(0.4)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
    }
}
