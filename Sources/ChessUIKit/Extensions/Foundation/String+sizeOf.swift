//
//  String+sizeOf.swift
//  TestChess
//
//  Created by MacBook Pro13 on 03.08.2024.
//

import UIKit

extension String {
    func sizeOf(_ font: UIFont) -> CGSize {
        let size = self.size(withAttributes: [NSAttributedString.Key.font: font])
        return CGSize(width: ceil(size.width), height: ceil(size.height))
    }
}
