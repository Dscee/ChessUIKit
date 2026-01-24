//
//  PawnPromotionView.swift
//  TestChess
//
//  Created by MacBook Pro13 on 03.07.2025.
//

import UIKit

final class DefaultPromotionPickerView: UIView {
    static private var isVisible = false

    private var imageViews: [UIImageView] = []
        
    var onSelectPiece: ((Piece) -> Void)?
    var onCancel: (() -> Void)?
    
    private var isAnimationComplete = false
    
    private let dimView = UIView()
    private let containerView = UIView()
    private let containerViewTransform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    private let pieceTransform =  CGAffineTransform(scaleX: 0.8, y: 0.8)
    
    private var preferredOriginInWindow: CGPoint?
    
    enum Piece {
        case queen, rook, knight, bishop
    }
    
    private func setupDimView() {
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.5)

//        dimView.pinToScreenEdges()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDimTap))
        dimView.addGestureRecognizer(tap)
    }
    
    @objc private func handleDimTap() {
        onCancel?()
        hide()
    }
    
    private func setupContainerView() {
        containerView.layer.cornerRadius = 4
        containerView.backgroundColor = .white.withAlphaComponent(0.80)
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 3
        containerView.transform = containerViewTransform
        containerView.alpha = 0
        
        containerView.layer.applySketchShadow(
            color: UIColor.yellow,
            alpha: 0.15,
            y: 0,
            blur: 20
        )
        
        containerView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(containerView)
        containerView.setConstraintsEqual(to: self)
    }
    
     func setup(images: [UIImage]) {
         setupContainerView()
        guard images.count == 4 else { return }
        
        imageViews = images.enumerated().map { (index, image) in
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true
            imageView.tag = index
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            imageView.addGestureRecognizer(tap)
            imageView.transform = pieceTransform
            imageView.alpha = 0
            imageView.heightAnchor.constraint(equalToConstant: 49).isActive = true
            return imageView
        }
        
        let grid = UIStackView()
        grid.axis = .vertical
        grid.distribution = .fillEqually
        grid.spacing = 4
        
        for i in 0..<2 {
            let row = UIStackView(arrangedSubviews: Array(imageViews[i*2..<i*2+2]))
            row.axis = .horizontal
            row.distribution = .fillEqually
            row.spacing = 4
            grid.addArrangedSubview(row)
        }

        grid.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(grid)
        containerView.becomeFirstResponder()
        NSLayoutConstraint.activate([
            grid.topAnchor.constraint(equalTo: containerView.topAnchor),
            grid.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            grid.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            grid.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        guard isAnimationComplete, let index = gesture.view?.tag else { return }
        let piece: Piece
        switch index {
        case 0: piece = .queen
        case 1: piece = .rook
        case 2: piece = .knight
        case 3: piece = .bishop
        default: return
        }
        onSelectPiece?(piece)
        hide()
    }
    
    // я б хотів щоб ти додав можливість задавати де саме показувати вьюшку на екрані, а в ту чергу ті координати мають потім конвертуватися в координати віндов екрану
    func show(images: [UIImage], parentView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(self)

        // Add dimView and containerView before applying constraints
        dimView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dimView)
        NSLayoutConstraint.activate([
            dimView.topAnchor.constraint(equalTo: topAnchor),
            dimView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dimView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        setupContainerView()
        setup(images: images)

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parentView.topAnchor),
            self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ])
    }
    
    func show() {
        isHidden = false
        isAnimationComplete = false
        animateContainerViewAppearance()

        imageViews.enumerated().forEach { i, imageView in
            animatePieceAppearance(pieceImageView: imageView, delay: 0.25 + (0.20 * TimeInterval(i)))
        }
    }
    
    func hide() {
        isAnimationComplete = false
 
        imageViews.enumerated().forEach { i, imageView in
            animatePieceDisappearance(pieceImageView: imageView, delay: 0.1 + (0.1 * TimeInterval(i)))
        }
        
        animateContainerViewDisappearance()
    }
    
    private func animateContainerViewAppearance() {
        UIView.animate(withDuration: 0.25, delay: 0, animations: { [weak self] in
            self?.containerView.transform = .identity
            self?.containerView.alpha = 1
            self?.dimView.alpha = 1
        })
    }
    
    private func animatePieceAppearance(pieceImageView: UIImageView, delay: TimeInterval) {
        UIView.animate(withDuration: 0.5, delay: delay, animations: { [weak self] in
            pieceImageView.transform = .identity
            pieceImageView.alpha = 1
        }, completion: { [weak self] _ in
            self?.isAnimationComplete = true
        })
    }
    
    private func animatePieceDisappearance(pieceImageView: UIImageView, delay: TimeInterval) {
        UIView.animate(withDuration: 0.3, delay: delay, animations: { [weak self] in
            guard let self else { return }
            pieceImageView.transform = self.pieceTransform
            pieceImageView.alpha = 0
        })
    }
    
    private func animateContainerViewDisappearance() {
        UIView.animate(withDuration: 0.21, delay: 0.7, animations: { [weak self] in
            guard let self else { return }
            self.containerView.transform = self.containerViewTransform
            self.containerView.alpha = 0
            self.dimView.alpha = 0
        },completion: { [weak self] isCompleted in
            guard isCompleted else { return }
            self?.removeFromSuperview()
        })
    }
}






import UIKit

@available(iOS 13.0, *)
extension UIView {
    /// Додає view до вікна і прикріплює по всіх краях
    func pinToScreenEdges() {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) else { return }

        self.translatesAutoresizingMaskIntoConstraints = false
        window.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: window.topAnchor),
            self.bottomAnchor.constraint(equalTo: window.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: window.trailingAnchor)
        ])
    }
}
