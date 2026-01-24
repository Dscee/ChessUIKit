//
//  MoveAssessmentContainerView.swift
//  ChessUIKit
//
//  Created by MacBook Pro13 on 29.07.2025.
//

import UIKit

final class MoveAssessmentContainerView: UIView {
    var isPlayerWhite = true
    
    func showMoveAssessmentView(
        with assessment: MoveAssessment,
        at coordinates: Coordinates
    ) {
        showMoveAssessmentView(
            with: assessment.image,
            at: coordinates
        )
    }
    
    func showMoveAssessmentView(
        with image: UIImage,
        at coordinates: Coordinates
    ) {
        let center = getIndicatorPosition(for: coordinates, isPlayerWhite: isPlayerWhite)
        let checkMarkImage = isPlayerWhite ? image : image.rotate(radians: .pi)!

        let checkMarkView = MoveAssessmentView(
            image: checkMarkImage,
            tintColor: .yellow,
            height: squareSize.height / 1.8,
            center: center
        )

        checkMarkView.animateAppearanceAndDisappearance()
        self.addSubview(checkMarkView)
    }
    
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        false
    }
    
    private func getSquareCenter(for coordinates: Coordinates) -> CGPoint {
        let squareCenter = squareSize.height / 2
        let x = squareCenter + (squareSize.width * CGFloat(coordinates.x))
        let y = squareCenter + (squareSize.width * CGFloat((coordinates.y)))
        
        return CGPoint(x: x, y: y)
    }
    
    private func getIndicatorPosition(for coordinates: Coordinates, isPlayerWhite: Bool) -> CGPoint {
        var center = getSquareCenter(for: coordinates)
        let offset: CGFloat = squareSize.width * 0.35

        if isPlayerWhite {
            center.x += coordinates.x == 7 ? -offset : offset
            center.y -= offset
        } else {
            center.x += coordinates.x == 0 ? offset : -offset
            center.y += offset
        }

        return center
    }
}
