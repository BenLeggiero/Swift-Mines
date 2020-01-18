//
//  Board Tests.swift
//  Swift MinesTests
//
//  Created by Ben Leggiero on 2020-01-07.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import XCTest
@testable import Swift_Mines



private let numberOfTestsForRandomizedApis = 50



class Board_Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testGenerateNewBoard_disallowingMinesNear() {
        
        let expectedClearLocations: [Board.Location] = [
            .init(x: 0, y: 0), .init(x: 1, y: 0), .init(x: 2, y: 0),
            .init(x: 0, y: 1), .init(x: 1, y: 1), .init(x: 2, y: 1),
            .init(x: 0, y: 2), .init(x: 1, y: 2), .init(x: 2, y: 2),
        ]
        
        for _ in 1...numberOfTestsForRandomizedApis {
            let board = Board.generateNewBoard(size: Board.Size(width: 5, height: 5),
                                               totalNumberOfMines: 5,
                                               disallowingMinesNear: Board.Location(x: 0, y: 0))
            
            XCTAssertFalse(expectedClearLocations.contains(where: board.hasMine), "Board must not have mine near first click at (0, 0)")
        }
    }
    
    
    func testNewGameFlow() {
        
        let firstTouchPoint = Board.Location(x: 3, y: 3)
        
        let expectedClearLocations: [Board.Location] = [
            .init(x: 1, y: 1), .init(x: 2, y: 1), .init(x: 3, y: 1), .init(x: 4, y: 1), .init(x: 5, y: 1),
            .init(x: 1, y: 2), .init(x: 2, y: 2), .init(x: 3, y: 2), .init(x: 4, y: 2), .init(x: 5, y: 2),
            .init(x: 1, y: 3), .init(x: 2, y: 3), .init(x: 3, y: 3), .init(x: 4, y: 3), .init(x: 5, y: 3),
            .init(x: 1, y: 4), .init(x: 2, y: 4), .init(x: 3, y: 4), .init(x: 4, y: 4), .init(x: 5, y: 4),
            .init(x: 1, y: 5), .init(x: 2, y: 5), .init(x: 3, y: 5), .init(x: 4, y: 5), .init(x: 5, y: 5),
        ]
        
        for _ in 1...numberOfTestsForRandomizedApis {
            var game = Game.new(size: Board.Size(width: 6, height: 6), totalNumberOfMines: 5)
            
            game.updateBoard(after: .dig, at: firstTouchPoint)
            
            XCTAssertFalse(game.board.hasMine(at: firstTouchPoint), "Game board must not have mine on first click at (\(firstTouchPoint.x), \(firstTouchPoint.y))")
            
            XCTAssertFalse(expectedClearLocations.contains(where: game.board.hasMine), "Game board must not have mine near first click at (\(firstTouchPoint.x), \(firstTouchPoint.y))")
        }
    }
}
