//
//  ChessboardCoordinatesView.swift
//  TestChess
//
//  Created by MacBook Pro13 on 25.06.2024.
//

import UIKit

final class CoordinatesView: UIView {
    enum Color {
        case white, black        
    }

    private(set) var fileLabels: [UILabel] = []
    private(set) var rankLabels: [UILabel] = []

    var configuration: CoordinatesConfiguration
    
    init(configuration: CoordinatesConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let ranks = ["a","b","c","d","e","f","g","h"]
    private let files =  Array(1...8)
    
    var renderingMode: Color = .white {
        didSet { update() }
    }

    func update() {
        let isWhite = renderingMode == .white
        
        let ranks = isWhite ? ranks  : ranks.reversed()
        
        ranks
            .enumerated()
            .forEach {
                rankLabels[$0.offset].text = $0.element
        }
        
        let files = isWhite ? files.reversed() : files
        
        files
            .enumerated()
            .forEach {
                fileLabels[$0.offset].text = "\($0.element)"
        }
    }
    
    private func setup() {
        files.reversed()
            .forEach { i in
                let label = UILabel()
                label.text = "\(i)"
                label.textColor = configuration.fileLabel.color
                label.font = configuration.fileLabel.font
                self.addSubview(label)
                fileLabels.append(label)
            }
        
        ranks
            .enumerated()
            .forEach { i, element in
                let label = UILabel()
                label.text = "\(element)"
                label.textColor = configuration.rankLabel.color
                label.font = configuration.rankLabel.font
                self.addSubview(label)
                rankLabels.append(label)
            }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
                
        setFileLabelsFrame()
        setRankLabelsFrame()
    }
    
    private func setFileLabelsFrame() {
        (0...7).forEach { i in
            let x = squareSize.height * 0
            let y = squareSize.height * CGFloat(i)
            let squareFrame = CGRect(origin: CGPoint(x: x, y: y), size: squareSize)
            let label = fileLabels[i]
            let labelSize = label.text!.sizeOf(configuration.fileLabel.font)
            let labelHeight = labelSize.height

//            let xPosition = isPlayerColorWhite ? squareFrame.minX + 2 : squareFrame.maxX - 11
//            let yPosition = isPlayerColorWhite ? squareFrame.maxY - labelHeight - 0.5 : squareFrame.minY
            
            let xPosition = squareFrame.minX + 2
            let yPosition = squareFrame.maxY - labelHeight - 0.5
            
            label.frame = CGRect(x: xPosition, y: yPosition, width: labelSize.width, height: labelHeight)
        }
    }
    
    private func setRankLabelsFrame() {
        (0...7).forEach { i in
            let x = squareSize.height * CGFloat(i)
            let y = squareSize.height * 7
            let squareFrame = CGRect(origin: CGPoint(x: x, y: y), size: squareSize)
            
            let label = rankLabels[i]
            let labelSize = label.text!.sizeOf(configuration.rankLabel.font)
            let labelHeight = labelSize.height
            let labelWidth = labelSize.width
            
            let xPosition = squareFrame.maxX - 9.5
            let yPosition = squareFrame.maxY - labelHeight - 1
                        
            label.frame = CGRect(x: xPosition, y: yPosition, width: labelWidth, height: labelHeight)
        }
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        false
    }
}

