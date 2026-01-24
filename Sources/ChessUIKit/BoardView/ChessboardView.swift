//
//  ChessboardView.swift
//  TestChess
//
//  Created by MacBook Pro13 on 17.05.2024.
//

import UIKit

public class ChessboardView: UIView {
    private let squaresView = SquaresView(configuration: .default)
    private let coordinatesView = CoordinatesView(configuration: .default)
    private let piecesView = PiecesView(pieces: [:])
    private let moveIndicatorsView = MoveIndicatorsView()
    private let arrowsView = ArrowsView()
        
    public var isCoordinatesHidden: Bool {
        get { coordinatesView.isHidden }
        set { coordinatesView.isHidden = newValue }
    }
    
    public var canDragPieceOutside: Bool {
        get { piecesView.canDragPieceOutside }
        set { piecesView.canDragPieceOutside = newValue }
    }
    
    public var indicatorHeight: CGFloat {
        get { moveIndicatorsView.height }
        set { moveIndicatorsView.height = newValue }
    }
    
    public var squareConfiguration: SquareConfiguration {
        get { squaresView.configuration }
        set { squaresView.configuration = newValue }
    }
    
    public var coordinatesConfiguration: CoordinatesConfiguration {
        get { coordinatesView.configuration }
        set { coordinatesView.configuration = newValue }
    }
    
    public var highlightedMoveView: HighlightedPositionView {
        get { piecesView.highlightedMoveView }
        set { piecesView.highlightedMoveView = newValue }
    }
        
    public weak var delegate: ChessboardViewDelegate?
    
    public var isFlipped = false {
        didSet {
            guard isFlipped != oldValue else { return }
            piecesView.isFlipped = isFlipped
            moveIndicatorsView.flipVertically(isFlipped)
            arrowsView.flipVertically(isFlipped)
            coordinatesView.renderingMode = isFlipped ? .black : .white
            squaresView.flipVertically(isFlipped)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public func squareView(at coordinates: Coordinates) -> UIView? {
        squaresView.getSquare(at: coordinates)
    }
    
    public func render(pieces: Set<Piece>) {
        clearBoard()
        
        piecesView.render(pieces: pieces)
    }
    
    public func render(fen: FEN) {
        let pieces = FENParser.render(fen: fen)
        render(pieces: Set(pieces))
    }
    
    public func make(move: Move, animated: Bool = true) {
        piecesView.make(move: move, animated: animated)
        clearBoard()
    }
    
    public func removePiece(at coordinates: Coordinates) {
        piecesView.removePiece(at: coordinates)
    }
    
    public func snapBackPiece(at coordinates: Coordinates, animated: Bool = true) {
        piecesView.snapBackPiece(at: coordinates)
    }
    
    public func highlight(square: Square) {
        squaresView.highlight(square: square)
    }
    
    public func highlight(
        squares: [Square],
        cleanPrevious: Bool = true
    ) {
        squaresView.highlight(
            squares: squares,
            clearPrevious: cleanPrevious
        )
    }
    
    public func unhighlight(squares: [Square]) {
        
    }
    
    public func jigglePiece(at coordinates: Coordinates) {
        piecesView.pieceViews[coordinates]?.jiggle()
    }
    
    public func unhighlightAllSquares() {
        squaresView.unhighlightAllSquares()
    }
    
    public func show(arrows: [Arrow]) {
        removeAllArrows()
        add(arrows: arrows)
    }
    
    public func add(arrows: [Arrow]) {
        arrowsView.add(arrows: arrows)
    }
    
    public func removeAllArrows() {
        arrowsView.removeAllArrows()
    }
    
    public func show(indicators: [Indicator]) {
        moveIndicatorsView.display(indicators: indicators)
    }
    
    public func removeAllIndicators() {
        moveIndicatorsView.removeAll()
    }
    
    public func clearBoard() {
        removeAllArrows()
        removeAllIndicators()
    }
    
    public func clearAllBoard() {
        piecesView.removeAllPieces()
        squaresView.unhighlightAllSquares()
        clearBoard()
    }
        
    public func flip() {
        isFlipped.toggle()
        
        piecesView.isFlipped = isFlipped
        moveIndicatorsView.flipVertically(isFlipped)
        arrowsView.flipVertically(isFlipped)
        coordinatesView.renderingMode = isFlipped ? .black : .white
        squaresView.flipVertically(isFlipped)
    }
}

private extension ChessboardView {
     func setup() {
         setupPiecesView()
         setupSubviewsConstraints()
    }
    
    func setupSubviewsConstraints() {
        [
            squaresView,
            piecesView,
            moveIndicatorsView,
            arrowsView,
            coordinatesView,
        ].forEach {
            addSubview($0)
            $0.setConstraintsEqual(to: self)
        }
    }
    
    func setupPiecesView() {
        piecesView.delegate = self
    }
}

extension ChessboardView: PiecesViewDelegate {
    func canPieceMakeMove(move: Move) -> Bool {
        guard let delegate else { return  false }

        return delegate.boardView(self, canPieceMakeMove: move)
    }
    
    func didTap(at coordinates: Coordinates) {
        delegate?.boardView(self, didTap: coordinates)
    }
    
    func didEndDraggingPiece(move: Move) {
        delegate?.didEndDraggingPiece(self, move: move)
    }
    
    func didStartMoveAnimation(move: Move) {
        delegate?.didStartMoveAnimation(self, move: move)
    }
    
    func canDragPiece(at coordinates: Coordinates) -> Bool {
        guard let delegate else { return  false }
        
        return delegate.boardView(self, canDragPieceAt: coordinates)
    }
    
    func didFinishMoveAnimation() {
        delegate?.didFinishMoveAnimation()
    }
}

enum Action {
    case makeMove(Move)
    case highlightSquares([Square])
    case showMoveIndicators([Indicator])
    case showArrows([Arrow])
}


extension UIView {
    func jiggle(amount: CGFloat = 5, duration: TimeInterval = 0.5, completion: (() -> Void)? = nil) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.linear
        )
        animation.duration = duration
        animation.values = [
            -amount, amount,
            -amount, amount,
            -amount / 2, amount / 2,
            -amount / 4, amount / 4,
            0
        ]
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion?()
        }
        
        layer.add(animation, forKey: "shake")
        
        CATransaction.commit()
    }
}
