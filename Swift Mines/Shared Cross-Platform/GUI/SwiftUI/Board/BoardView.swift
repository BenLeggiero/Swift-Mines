//
//  BoardView.swift
//  Swift Mines
//
//  Created by Ben Leggiero on 2019-12-04.
//  Copyright © 2019 Ben Leggiero BH-1-PS
//

import SwiftUI
import RectangleTools
import SafePointer



internal struct BoardView: View {
    
    @EnvironmentObject
    var overallAppState: OverallAppState
    
    private var onSquareTapped = MutableSafePointer<OnSquareTapped?>(to: nil)
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                ForEach(self.overallAppState.game.board.content, id: \.self) { row in
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(row, id: \.self) { square in
                            BoardSquareView(
//                                style: self.style(for: square),
                                model: square
                            )
//                                .also { print(square.cachedLocation.humanReadableDescription, square.base.externalRepresentation) }
                                .gesture(TapGesture().modifiers(.control).onEnded({ _ in self.onSquareTapped.pointee?(square, .placeFlag(style: .automatic)) }))
                                .gesture(TapGesture().onEnded({ self.onSquareTapped.pointee?(square, .dig) }))
                                .onLongPressGesture { self.onSquareTapped.pointee?(square, .placeFlag(style: .automatic)) }
//                                .also { print("\tBoardView Did attach listeners to board square view at", square.cachedLocation) }
                        }
                    }
                }
            }
            .background(Color(self.overallAppState.game.board.style.baseColor))
        }
//        .also { print("BoardView Did regenerate view with \(overallAppState.game.board.content.size.area) squares") }
    }
    
    
    
    public typealias OnSquareTapped = (_ square: BoardSquare.Annotated, _ action: Game.UserAction) -> Void
}



internal extension BoardView {
    
    func onSquareTapped(perform responder: @escaping OnSquareTapped) -> BoardView {
        self.onSquareTapped.pointee = { square, action in
            responder(square, action)
        }
        return self
    }
}



private extension BoardView {
    
    func handleUserDidTap(_ square: BoardSquare.Annotated) -> OnGestureDidEnd {{
        print("Tap")
        self.onSquareTapped.pointee?(square, .dig)
    }}
    
    
    func handleUserDidAltTap(_ square: BoardSquare.Annotated) -> OnGestureDidEnd {{
        print("Tap2")
        self.onSquareTapped.pointee?(square, .placeFlag(style: .automatic))
    }}
    
    
    
    typealias OnGestureDidEnd = () -> Void
}