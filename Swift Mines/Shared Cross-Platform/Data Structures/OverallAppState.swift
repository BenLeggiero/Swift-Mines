//
//  OverallAppState.swift
//  Swift Mines for macOS
//
//  Created by Ben Leggiero on 2020-01-09.
//  Copyright © 2020 Ben Leggiero BH-2-PC
//

import SwiftUI



/// The overall state of the app. Reading this will let you re-create the runtime from nothing.
public struct OverallAppState {
    
    /// The current game that the player is playing
    public var game: Game
    
    /// The current screen that the player is seeing
    public var currentScreen = AppScreen.appropriateStartupScreen
    
    /// The state of the Out-Of-Box Experience
    public var oobeState = OobeState.shared
    
    
    init(game: Game) {
        self.game = game
    }
}



public extension OverallAppState {
    
    /// The key which represents the app state as a kind of observable object
    static let key = Key.self
    
    
    
    /// The type of key which is used to represent the app state as a kind of observable object
    enum Key: EnvironmentKey {
        
        public typealias Value = OverallAppState
        
        
        
        /// The default app state, if none is yet made
        public static let defaultValue = OverallAppState(game: Game.basicNewGame())
    }
}



public extension EnvironmentValues {
    var overallAppState: OverallAppState {
        get { self[OverallAppState.key] }
        set { self[OverallAppState.key] = newValue}
    }
}
