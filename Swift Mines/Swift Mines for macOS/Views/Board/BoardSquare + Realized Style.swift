//
//  BoardSquare + Realized Style.swift
//  Swift Mines for macOS
//
//  Created by Ben Leggiero on 2019-12-18.
//  Copyright © 2020 Ben Leggiero BH-2-PC
//

import CrossKitTypes



internal extension BoardSquare.Annotated {
    /// Uses the square, its inherited style, and its current fields, to determine the best color to show behind it
    func appropriateBackgroundColor() -> NativeColor {
        switch self.base.externalRepresentation {
        case .blank,
             .flagged(style: _):
            return inheritedStyle.baseColor
            
        case .revealed:
            return inheritedStyle.baseColor.withSystemEffect(.pressed)
        }
    }
}
