//
//  SquareConfiguration+default.swift
//  TestChess
//
//  Created by MacBook Pro13 on 03.08.2024.
//

import UIKit

@MainActor
public extension SquareConfiguration {
    static let `default` = SquareConfiguration(
        whiteColor: UIColor(hex: "F1F4E9"),
        blackColor: UIColor(hex: "85A665")
    )
}
