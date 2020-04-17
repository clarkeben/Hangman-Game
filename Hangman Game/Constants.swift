//
//  Constants.swift
//  Hangman Game
//
//  Created by Ben Clarke on 17/04/2020.
//  Copyright © 2020 Ben Clarke. All rights reserved.
//

import Foundation

struct K {
    
    static let appName = "Hangman ☠️"
    static let gameSeugue = "goToGame"
    
    enum difficulty {
        case hard
        case medium
        case easy
    }
    
    static func returnDifficulty(difficultyChosen: difficulty) -> Int {
        switch difficultyChosen {
        case .hard:
            return 5
        case .medium:
            return 10
        case .easy:
            return 20
        }
    }
    
    struct Difficulty {
        static let hard = "Hard"
        static let medium = "Medium"
        static let easy = "Easy"
    }
    
}
