//
//  UIApplication+activeKeyWindow.swift
//  TestChess
//
//  Created by MacBook Pro13 on 03.07.2025.
//

import UIKit

extension UIApplication {
    var activeKeyWindow: UIWindow? {
        if #available(iOS 15.0, *) {
            return connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first(where: \.isKeyWindow)
        } else {
            return windows.first(where: \.isKeyWindow)
        }
    }
}
