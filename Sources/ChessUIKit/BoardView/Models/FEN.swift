//
//  FEN.swift
//  ChessUIKit
//
//  Created by MacBook Pro13 on 04.07.2025.
//

import Foundation

public struct FEN {
    let position: String
    let sideToMove: Color
    let legalCastlings: LegalCastlings
    let enPassant: String
    let clock: Clock
    let rawValue: String
    
    public init(fromString fen: String) throws {
        guard !fen.isEmpty else {
            throw Error.emptyFEN
        }
        
        let splittedFEN = fen.components(separatedBy: " ")
        
        guard splittedFEN.count == 6  else {
            throw Error.invalidFEN
        }
        
        self.position = try FEN.getPosition(from: splittedFEN.first ?? "")
        
        let sideToMoveString = splittedFEN[1]
        self.sideToMove = try FEN.getSideMove(from: sideToMoveString)
        
        let legalCastlingsString = splittedFEN[2]
        self.legalCastlings = try .init(from: legalCastlingsString)
        
        let enPassantString = splittedFEN[2]
        self.enPassant = try FEN.getEnPassant(from: enPassantString)
        
        let halfMovesString = splittedFEN[4]
        let fullMovesString = splittedFEN[5]
        
        self.clock = try FEN.getClock(halfMoves: halfMovesString, fullMoves: fullMovesString)
        self.rawValue = fen
    }
    
    private static func getPosition(from string: String) throws -> String {
        guard !string.isEmpty else {
            throw Error.emptyPosition
        }
        
        let slashesCount = string.filter { $0 == "/" }.count
        
        guard slashesCount == 7 else {
            throw Error.invalidPosition
        }
        
        return string
    }
    
    private static func getSideMove(from string: String) throws -> Color {
        guard let sideToMove = Color.init(rawValue: string) else {
            throw Error.invalidColor
        }
        
        return sideToMove
    }
    
    private static func getEnPassant(from string: String) throws -> String {
        guard string.contains("-") || string.count <= 4 else {
            throw Error.invalidEnPassant
        }
        
        return string
    }
    
    private static func getClock(halfMoves: String, fullMoves: String) throws -> Clock {
        guard !halfMoves.isEmpty && !fullMoves.isEmpty else {
            throw Error.clockIsEmpty
        }
        
        let halfMovesInt = Int(halfMoves) ?? 0
        let fullMovesInt = Int(fullMoves) ?? 0
        
        guard halfMovesInt >= 0 && fullMovesInt >= 0 else {
            throw Error.invalidClock
        }
        
        return Clock(halfMoves: halfMovesInt, fullMoves: fullMovesInt)
    }
}



extension FEN {
    fileprivate enum Error: Swift.Error {
        case emptyFEN
        case invalidFEN
        case emptyPosition
        case invalidPosition
        case invalidColor
        case invalidEnPassant
        case clockIsEmpty
        case invalidClock
        case incorecctPosition
    }
    
    enum Color: String {
        case white = "w", black = "b"
    }
    
    public struct LegalCastlings {
        private var legal: [Castling]
        
        
        init(legal: [Castling] = [.bK, .wK, .bQ, .wQ]) {
            self.legal = legal
        }
        
        enum Error: Swift.Error {
            case invalidLegalCastlings
        }
        
        init(from string: String) throws {
            guard string.count >= 1 && string.count <= 4  else {
                throw Error.invalidLegalCastlings
            }
            
            legal = string.compactMap {
                Castling(rawValue: String($0))
            }
        }
        
        enum Castling: String {
            case wK = "K", bK = "k", wQ = "Q", bQ = "q"
        }
    }
    
    public struct Clock: Equatable {
        static let halfMoveMaximum = 100
        public var halfMoves = 0
        public var fullMoves = 1
    }
}

extension FEN: Equatable {
    public static func == (lhs: FEN, rhs: FEN) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}
