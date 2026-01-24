//
//  MoveAssessmentView.swift
//  TestChess
//
//  Created by MacBook Pro13 on 19.09.2024.
//

import UIKit

final class MoveAssessmentView: UIImageView {
    init(image: UIImage, tintColor: UIColor, height: CGFloat, center: CGPoint) {
        super.init(image: image)
        setup(with: tintColor, height: height, center: center)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup(with tintColor: UIColor, height: CGFloat, center: CGPoint) {
        backgroundColor = .white
        self.tintColor = tintColor
        frame = CGRect(origin: .zero, size: CGSize(width: height, height: height))
        self.center = center
        layer.cornerRadius = frame.height / 2
    }
    
    func animateAppearance(onComplete: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { _ in
            onComplete()
        }
    }
    
    func animateDisappearance(onComplete: @escaping () -> Void) {
        UIView.animate(withDuration: 0.2, delay: 0.5, options: [], animations: {
            self.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    func animateAppearanceAndDisappearance() {
        animateAppearance {
            self.animateDisappearance {}
        }
    }
}
