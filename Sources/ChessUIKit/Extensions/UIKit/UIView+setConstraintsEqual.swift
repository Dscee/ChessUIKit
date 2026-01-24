//
//  UIView+setConstraintsEqual.swift
//  TestChess
//
//  Created by MacBook Pro13 on 29.06.2024.
//

import UIKit

extension UIView {
    func setConstraintsEqual(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
