//
//  RulesData.swift
//  Hangman Game
//
//  Created by Ben Clarke on 25/04/2020.
//  Copyright © 2020 Ben Clarke. All rights reserved.
//

import Foundation

struct rulesData {
    
    static let gamesRulesTitle = [
        "1. The aim",
        "2. Guess the letter",
        "3. Lives",
        "4. Points",
        "5. Clues",
        "6. Winning"
    ]
    
    static let gamesRules = [
        "Guess the word before the hangman is hung and get as many points as you can.",
        "When you get a letter right you’ll see where that letter goes in the word.",
        "You start with 10 lives until the hangman is hung",
        "You gain a point for correct guesses and loose a point for incorrect guesses.",
        "You get one clue per word, but you sacrifice a point and life for each clue.",
        "If you guess the word right, you can continue playing with a new word."
    ]
}
