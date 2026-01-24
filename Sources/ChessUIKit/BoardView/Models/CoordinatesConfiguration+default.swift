//
//  CoordinatesConfiguration+default.swift
//  TestChess
//
//  Created by MacBook Pro13 on 03.08.2024.
//

import UIKit

@MainActor
extension CoordinatesConfiguration {
    static let `default` = CoordinatesConfiguration(
        fileLabel: Label(
            color: UIColor(hex: "1A1B20").withAlphaComponent(0.5),
            font: UIFont.systemFont(
                ofSize: 11,
                weight: .semibold
            )
        ),
        rankLabel: Label(
            color: UIColor(hex: "1A1B20").withAlphaComponent(0.5),
            font: UIFont.systemFont(
                ofSize: 11,
                weight: .semibold
            )
        )
    )
}
