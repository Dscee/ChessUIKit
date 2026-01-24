//
//  Array+toDictionary.swift
//  TestChess
//
//  Created by MacBook Pro13 on 18.09.2024.
//

import Foundation

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}

