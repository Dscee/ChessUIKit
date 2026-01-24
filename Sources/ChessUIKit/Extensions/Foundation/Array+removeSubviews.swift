//
//  Array+removeSubviews.swift
//  TestChess
//
//  Created by MacBook Pro13 on 18.09.2024.
//

import UIKit

extension Array where Element: UIView {
    @MainActor
   func removeSubviews() {
       self.forEach { $0.removeFromSuperview() }
   }
}
