//
//  ChessPiecesView.swift
//  TestChess
//
//  Created by MacBook Pro13 on 25.06.2024.
//

import UIKit

@MainActor
protocol PiecesViewDelegate: AnyObject {
    func didTap(at coordinates: Coordinates)
    func canPieceMakeMove(move: Move) -> Bool
    func canDragPiece(at coordinates: Coordinates) -> Bool
    func didEndDraggingPiece(move: Move)
    func didFinishMoveAnimation()
    func didStartMoveAnimation(move: Move)
}

final class PiecesView: UIView {
    var isFlipped = false {
        didSet { flip() }
    }
    
    var canDragPieceOutside = false
    
    var pieceAnimator: PieceAnimationProvider = DefaultPieceAnimator()
    var highlightedMoveView = HighlightedPositionView()
    
    weak var delegate: PiecesViewDelegate?
    
    var pieceSize: CGSize {
        CGSize(
            width: squareSize.width * 0.89,
            height: squareSize.height * 0.89
        )
    }
    
    lazy var highlightedPositionSize: CGSize = {
        CGSize(
            width: squareSize.width * 2.4,
            height: squareSize.width * 2.4
        )
    }()
    
    private(set) var pieceViews: [Coordinates: PieceView]
    
    private var isInitialSetupCompleted = false
    private var movesInProgress = Set<Coordinates>()
    
    init(pieces: [Coordinates: PieceView]) {
        self.pieceViews = pieces
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func make(move: Move, animated: Bool = true) {
        guard let pieceView = pieceViews[move.from] else {
            return
        }
        
        // Prevent concurrent animations for the same piece
        guard !movesInProgress.contains(move.from) else {
            return
        }
         
        guard animated else {
            pieceView.center = getSquareCenter(for: move.to)
            pieceViews[move.to]?.removeFromSuperview()
            pieceViews[move.to] = pieceView
            pieceView.coordinates = move.to
            
            if let updatedImage = move.replaceImage {
                pieceViews[move.to]?.image = isFlipped ? updatedImage.rotate(radians: .pi)! : updatedImage
            }
            
            pieceViews[move.from] = nil
            
            return
        }
        
        // Mark animation as in progress
        movesInProgress.insert(move.from)
        
        let toCenter = getSquareCenter(for: move.to)
        
        pieceAnimator.animate(
            animations: { [weak self] in
                guard let self else { return }
                delegate?.didStartMoveAnimation(move: move)
                bringSubviewToFront(pieceView)
                pieceView.center = toCenter
            }, completion: { [weak self] _ in
                guard let self else { return }
                
                pieceViews[move.to]?.removeFromSuperview()
                pieceViews[move.to] = pieceView
                pieceView.coordinates = move.to
                
                if let updatedImage = move.replaceImage {
                    pieceViews[move.to]?.image = isFlipped ? updatedImage.rotate(radians: .pi)! : updatedImage
                }
                
                pieceViews[move.from] = nil
                
                // Remove from tracking after animation completes
                movesInProgress.remove(move.from)
                
                delegate?.didFinishMoveAnimation()
            }
        )
    }

    func render(pieces: Set<Piece>) {
        if !pieces.isEmpty {
            removeAllPieces()
        }
        
        pieces.forEach { piece in
            let pieceView = PieceView(
                image: isFlipped ? piece.image.rotate(radians: .pi)! : piece.image,
                coordinates: piece.coordinates,
                isFlipped: isFlipped,
                squareSize: squareSize,
                frame: frame(for: piece.coordinates, size: pieceSize)
            )
                                    
            pieceView.delegate = self
            
            pieceViews[piece.coordinates] = pieceView
            
            addSubview(pieceView)
        }
    }
    
    public func removePiece(at coordinates: Coordinates) {
        pieceViews[coordinates]?.removeFromSuperview()
        pieceViews[coordinates] = nil
    }
    
    public func snapBackPiece(at coordinates: Coordinates, animated: Bool = true) {
        if animated {
            pieceAnimator.animate(animations: { [weak self] in
                guard let self else { return }
                pieceViews[coordinates]?.center = getSquareCenter(for: coordinates)
            }, completion: nil)
        } else {
            pieceViews[coordinates]?.center = getSquareCenter(for: coordinates)
        }
    }
    
    func removeAllPieces() {
        pieceViews.removeAll()
        
        for subview in subviews where subview is PieceView {
            subview.removeFromSuperview()
        }
    }
    
    private func setupView() {
        highlightedMoveView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(highlightedMoveView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        DispatchQueue.main.async {
            self.initialSetup()
        }
    }
    
    @objc private func tap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        let coordinates = getPosition(from: location)
        delegate?.didTap(at: coordinates)
    }
    
    private func getPosition(from point: CGPoint) -> Coordinates {
           let file = Int(point.x / squareSize.width)
           let rank = Int(point.y / squareSize.height)
           return Coordinates(x: file, y: rank)
           return isFlipped
               ? Coordinates(x: file, y: rank)
               : Coordinates(x: 7 - file, y: 7 - rank)
       }

    
     func frame(for coordinates: Coordinates, size: CGSize) -> CGRect {
        let toSquareFrame = frame(
            x: CGFloat(coordinates.x),
            y: CGFloat(coordinates.y),
            size: squareSize
        )
        
        let centeredX = toSquareFrame.midX - size.width / 2
        let centeredY = toSquareFrame.midY - size.height / 2
        
        return CGRect(
            x: centeredX,
            y: centeredY,
            width: size.width,
            height: size.height
        )
    }
    
    private func initialSetup() {
        if isInitialSetupCompleted {
            return
        }
                
        pieceViews.forEach {
            $0.value.frame = frame(
                for: $0.key,
                size: .init(
                    width: squareSize.width * 0.89,
                    height: squareSize.height * 0.89
                )
            )
            
            $0.value.square1Size = squareSize
            $0.value.isFlipped = isFlipped
        }
        
        isInitialSetupCompleted = true
    }
    
    private func getSquareCenter(for coordinates: Coordinates) -> CGPoint {
        let squareCenter = squareSize.height / 2
        let x = squareCenter + (squareSize.width * CGFloat(coordinates.x))
        let y = squareCenter + (squareSize.width * CGFloat((coordinates.y)))
        
        return CGPoint(x: x, y: y)
    }
    
    private func flip() {
        flipVertically(isFlipped)
        
        pieceViews.forEach {
            $1.image = $1.image?.rotate(radians: .pi)
            $1.isFlipped = isFlipped
        }
    }
}


extension PiecesView: PieceViewDelegate {
    func canPieceMakeMove(_ pieceView: PieceView, move: Move) -> Bool {
        guard let delegate else { return false }
        
        return delegate.canPieceMakeMove(move: move)
    }
    
    func didStartDragging(_ pieceView: PieceView) {
        
    }
    
    func canDragPiece(_ pieceImageView: PieceView) -> Bool {
        guard let delegate else { return false }
        
        return delegate.canDragPiece(at: pieceImageView.coordinates)
    }
    
    func willDragPieceOutsideBoard(_ pieceImageView: PieceView) {
        highlightedMoveView.isHidden = true
        
        if canDragPieceOutside {
            
        }
    }
    
    func didEndDraggingPiece(_ pieceImageView: PieceView, to newCoordinates: Coordinates) {
        highlightedMoveView.isHidden = true
        
        guard pieceImageView.coordinates != newCoordinates else { return }
        
        let move = Move(
            from: pieceImageView.coordinates,
            to: newCoordinates
        )!
        
        delegate?.didEndDraggingPiece(move: move)
    }
    
    func draggingPiece(_ pieceImageView: PieceView, to coordinates: Coordinates) {
        highlightedMoveView.frame = frame(for: coordinates, size: highlightedPositionSize)
        highlightedMoveView.isHidden = false
    }
    
    func didTap(_ pieceImageView: PieceView) {
        delegate?.didTap(at: pieceImageView.coordinates)
    }
}
