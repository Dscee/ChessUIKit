//
//  File.swift
//  ChessUIKit
//
//  Created by MacBook Pro13 on 18.07.2025.
//

import UIKit

final public class CZBoardView: ChessboardView {
    private let moveAssessmentContainerView: MoveAssessmentContainerView = {
        let view = MoveAssessmentContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    public override var isFlipped: Bool {
        didSet {
            moveAssessmentContainerView.isPlayerWhite = !isFlipped
            moveAssessmentContainerView.flipVertically(isFlipped)
        }
    }

    public func showPromotionPicker(
        isWhite: Bool
    ) {
        let view = DefaultPromotionPickerView()
        
        view.onSelectPiece = { [weak self] in
            switch $0 {
            case .queen:
                self?.delegate?.didSelectPromotedPiece(promotedPiece: .queen)
            case .rook:
                self?.delegate?.didSelectPromotedPiece(promotedPiece: .rook)
            case .knight:
                self?.delegate?.didSelectPromotedPiece(promotedPiece:.knight)
            case .bishop:
                self?.delegate?.didSelectPromotedPiece(promotedPiece: .bishop)
            }
        }
        
        let prefix = "S\(isWhite ? "W" : "B")_"
        
        view.setup(images: [
            .init(named: "\(prefix)Queen",in: .module, with: .none)!,
            .init(named: "\(prefix)Rook", in: .module, with: .none)!,
            .init(named: "\(prefix)Knight", in: .module, with: .none)!,
            .init(named: "\(prefix)Bishop", in: .module, with: .none)!,
        ])
         
         view.translatesAutoresizingMaskIntoConstraints = false

         addSubview(view)

         NSLayoutConstraint.activate([
             view.centerXAnchor.constraint(equalTo: centerXAnchor),
             view.centerYAnchor.constraint(equalTo: centerYAnchor)
         ])
        
        view.show()
    }
    
    public func showMoveAssessmentView(
        with assessment: MoveAssessment,
        at coordinates: Coordinates
    ) {
        moveAssessmentContainerView.showMoveAssessmentView(
            with: assessment,
            at: coordinates
        )
    }
    
    public func showMoveAssessmentView(
        with image: UIImage,
        at coordinates: Coordinates
    ) {
        moveAssessmentContainerView.showMoveAssessmentView(
            with: image,
            at: coordinates
        )
    }
    
    private func setup() {
        addSubview(moveAssessmentContainerView)
        moveAssessmentContainerView.setConstraintsEqual(to: self)
    }
}
