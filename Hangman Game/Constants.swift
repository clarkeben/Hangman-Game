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
    static let settingsVCName = "Settings ⚙️"
    static let howTopPlayVCName = "How To Play 🕹️"
    
    static let gameSeugue = "goToGame"
    static let howToPlaySegue = "goToHowToPlay"
    static let settingsSegue = "goToSettings"
    
    /*enum difficulty {
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
     }*/
    
    struct rules {
        
        static let cellName = "rulesCell"
        
        static let gamesRulesTitle = [
            "1. Introduction",
            "2. Words",
            "3. Lives",
            "4. Points",
            "5. Clues",
            "6. Winning/loosing"
        ]
        
        static let gamesRules = [
            "Hangman is an easy game which involves the player guessing a word.",
            "A word of medium length is generated and the user has to guess the word using the letters available.",
            "The player starts with 10 lives, each time an answer is guessed correctly the player will be able to see the letter on screen - in relation to its current position.",
            "If the player guesses incorrectly, they loose a point and a life.",
            "There is the possibility of the user using a clue once per game, however, this also results in a point and life being deducted.",
            "Should a player loose or win, a new word will be generated and their current score will be updated to the total score."
        ]
    }
    
}
