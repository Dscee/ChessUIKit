//
//  ChessPieceView.swift
//  TestChess
//
//  Created by MacBook Pro13 on 29.06.2024.
//

import UIKit

final class PieceView: UIView {
    var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }
    
    var coordinates: Coordinates
    var square1Size: CGSize
    var isFlipped: Bool = false
    var pieceOffsetOnDrag: CGFloat = 40
    var pieceTransformOnDrag = CGAffineTransform(scaleX: 2, y: 2) {
        didSet { transform = pieceTransformOnDrag }
    }
    
    weak var delegate: PieceViewDelegate?
    
    private var initialPositionCenter: CGPoint = .zero
    
    private let imageView = UIImageView()
    
    init(
        image: UIImage,
        coordinates: Coordinates,
        isFlipped: Bool,
        squareSize: CGSize,
        frame: CGRect = .zero
    ) {
        self.coordinates = coordinates
        self.square1Size = squareSize
        self.isFlipped = isFlipped
        super.init(frame: frame)
        self.image = image
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.frame = bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(imageView)

        isUserInteractionEnabled = true

        let panGestureRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(handlePan)
        )
        
        addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didTap)
        )
        
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    private var initialTouchLocation: CGPoint?
    
    @objc func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        guard let superview = superview as? PiecesView else {
            fatalError("Piece image view superview is nil")
        }
        
        guard let delegate else {
            fatalError("Piece image view delegate is nil")
        }
        
        let translation = gestureRecognizer.translation(in: superview)
        
        switch gestureRecognizer.state {
        case .began:
            guard delegate.canDragPiece(self) else { return }
            delegate.didStartDragging(self)
            
            let location = gestureRecognizer.location(in: superview)
            initialTouchLocation = location
            
            transform = pieceTransformOnDrag
            initialPositionCenter = center
            superview.bringSubviewToFront(self)
        case .changed:
            let newX = center.x + translation.x
            let newY = center.y + translation.y
            
            guard let initialTouchLocation else { return }
                   
            let pieceOffsetOnDrag = isFlipped ? pieceOffsetOnDrag : -pieceOffsetOnDrag
            
            let currentTouchLocation = CGPoint(
                x: initialTouchLocation.x + translation.x,
                y: initialTouchLocation.y + translation.y + pieceOffsetOnDrag
            )
            
            let currentCoordinate = getPosition(from: currentTouchLocation, size: superview.squareSize)
            
            delegate.draggingPiece(self, to: currentCoordinate)

            if !isPieceWithinBoardBounds(location: currentTouchLocation) {
                delegate.willDragPieceOutsideBoard(self)
            }
            
            center = currentTouchLocation
            
        case .ended:
            transform = .identity
            
            let location = gestureRecognizer.location(in: superview)
            
            if !isPieceWithinBoardBounds(location: location) {
                center = initialPositionCenter
                delegate.willDragPieceOutsideBoard(self)
                return
            }
            
            let squareSideSize = squareSize.width

//            let xPosition = Int(location.x / squareSideSize) * Int(squareSideSize) + Int(squareSideSize / 2) + 1
//            let yPosition = Int(location.y / squareSideSize) * Int(squareSideSize) + Int(squareSideSize / 2) + 1
//
//            let currentTouchLocation =  CGPoint(x: CGFloat(xPosition), y: CGFloat(yPosition))
            
            let newX = center.x + translation.x
            let newY = center.y + translation.y
            
            guard let initialTouchLocation else { return }
                   
            let pieceOffsetOnDrag = isFlipped ? pieceOffsetOnDrag : -pieceOffsetOnDrag
            
            let currentTouchLocation = CGPoint(
                x: initialTouchLocation.x + translation.x,
                y: initialTouchLocation.y + translation.y + pieceOffsetOnDrag
            )
            
            
    
            let currentCoordinate = getPosition(from: currentTouchLocation, size: superview.squareSize)
            
            
            if coordinates == currentCoordinate {
                center = initialPositionCenter
                self.initialTouchLocation = nil
                delegate.didEndDraggingPiece(self, to: currentCoordinate)
                return
            }

            
            print("Hello", currentCoordinate)
            delegate.didEndDraggingPiece(self, to: currentCoordinate)

        default: break
        }
    }
    
    @objc func didTap(gesture: UITapGestureRecognizer) {
        delegate?.didTap(self)
    }
    
    func getPosition(from location: CGPoint, size: CGSize) -> Coordinates {
        return Coordinates(
            x: Int(location.x / size.width),
            y: Int(location.y / size.height)
        )
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.contains(point)
    }
    
    func isPieceWithinBoardBounds(location: CGPoint) -> Bool {
        guard let superview else { return false }
        
        return location.y < superview.bounds.height && location.y > 0 && location.x < superview.bounds.width && location.x >= 0
    }
}

extension UIView {
    func addDragging() {
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedAction(_ :)))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc private func draggedAction(_ pan: UIPanGestureRecognizer){
        
        let translation = pan.translation(in: self.superview)
        self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
        pan.setTranslation(CGPoint.zero, in: self.superview)
    }
}
