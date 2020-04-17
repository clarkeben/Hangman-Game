//
//  ViewController.swift
//  Hangman Game
//
//  Created by Ben Clarke on 09/04/2020.
//  Copyright © 2020 Ben Clarke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var guessesRemainingLabel: UILabel!
    
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    @IBOutlet weak var buttonE: UIButton!
    @IBOutlet weak var buttonF: UIButton!
    @IBOutlet weak var buttonG: UIButton!
    @IBOutlet weak var buttonH: UIButton!
    @IBOutlet weak var buttonI: UIButton!
    @IBOutlet weak var buttonJ: UIButton!
    @IBOutlet weak var buttonK: UIButton!
    @IBOutlet weak var buttonL: UIButton!
    @IBOutlet weak var buttonM: UIButton!
    @IBOutlet weak var buttonN: UIButton!
    @IBOutlet weak var buttonO: UIButton!
    @IBOutlet weak var buttonP: UIButton!
    @IBOutlet weak var buttonQ: UIButton!
    @IBOutlet weak var buttonR: UIButton!
    @IBOutlet weak var buttonS: UIButton!
    @IBOutlet weak var buttonT: UIButton!
    @IBOutlet weak var buttonU: UIButton!
    @IBOutlet weak var buttonV: UIButton!
    @IBOutlet weak var buttonW: UIButton!
    @IBOutlet weak var buttonX: UIButton!
    @IBOutlet weak var buttonY: UIButton!
    @IBOutlet weak var buttonZ: UIButton!
    
    //  Array for all words + letters
    
    var buttonsArray = [UIButton]()
    
    var wordLetterArray = [String]()
    var word = ""
    
    var maskedWord = ""
    var maskedWordArray = [String]()
    
    var wordStrings = [String]()
    var level = 1
    var levelCompleted = false
    var usedLetters = ""
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    // Consider adding loading screen
    var livesRemaining = 10 {
        didSet {
            guessesRemainingLabel.text = "\(livesRemaining) guesses left"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = K.appName
        navigationController?.navigationBar.prefersLargeTitles =  true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clue", style: .plain, target: self, action: #selector(giveClue))
        
        buttonsArray.append(buttonA)
        buttonsArray.append(buttonB)
        buttonsArray.append(buttonC)
        buttonsArray.append(buttonD)
        buttonsArray.append(buttonE)
        buttonsArray.append(buttonF)
        buttonsArray.append(buttonG)
        buttonsArray.append(buttonH)
        buttonsArray.append(buttonI)
        buttonsArray.append(buttonJ)
        buttonsArray.append(buttonK)
        buttonsArray.append(buttonL)
        buttonsArray.append(buttonM)
        buttonsArray.append(buttonN)
        buttonsArray.append(buttonO)
        buttonsArray.append(buttonP)
        buttonsArray.append(buttonQ)
        buttonsArray.append(buttonR)
        buttonsArray.append(buttonS)
        buttonsArray.append(buttonT)
        buttonsArray.append(buttonU)
        buttonsArray.append(buttonV)
        buttonsArray.append(buttonW)
        buttonsArray.append(buttonX)
        buttonsArray.append(buttonY)
        buttonsArray.append(buttonZ)
        
        loadGame()
    }
    
    @objc func giveClue() {
        
        let filteredLetters = wordLetterArray.filter { !$0.contains(usedLetters) }
        guard let randomElement = filteredLetters.randomElement()?.capitalized else { return }
        
        let wordLen = wordLetterArray.count
        
        showAlertAction(title: "🕵️", message: "The current word is \(wordLen) characters, have you considered using the letter '\(randomElement)'?", actionClosure: {})
        
        score -= 1
        livesRemaining -= 1
        
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    
    @IBAction func letterTapped(_ sender: UIButton) {
        guard let letterChosen = sender.currentTitle?.lowercased() else { return }
        
        usedLetters.append(letterChosen)
        
        if wordLetterArray.contains(letterChosen) {
            
            for (index, letter) in wordLetterArray.enumerated() {
                if letterChosen == letter {
                    maskedWordArray[index] = letter
                }
            }
            
            maskedWord = maskedWordArray.joined()
            score += 1
            
        } else {
            score -= 1
            livesRemaining -= 1
        }
        
        sender.isEnabled = false
        wordLabel.text = maskedWord
        
        // check to see if the game is completed + reset
        checkToSeeIfCompleted()
        
        if levelCompleted {
            for button in buttonsArray {
                button.isEnabled = true
            }
            levelCompleted = false
        }
        
    }
    
    func loadGame() {
        // Read data from disk on BG thread
        
        if let fileURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let wordContents = try? String(contentsOf: fileURL) {
                var lines = wordContents.components(separatedBy: "\n")
                lines.shuffle()
                wordStrings += lines
            }
        } else {
            showAlertAction(title: "Error", message: "There was an error fetching data, please try again!", actionClosure: {})
        }
        
        loadWord()
    }
    
    
    func checkToSeeIfCompleted() {
        
        if livesRemaining > 0 {
            
            if maskedWord == word {
                level += 1
                showAlertAction(title: "Congratualtions 🎉", message: "You've beat the hangman", actionTitle: "Restart", actionClosure: self.loadWord)
                levelCompleted = true
            }
            
        } else {
            level += 1
            showAlertAction(title: "💀", message: "The hangman caught you", actionTitle: "Restart", actionClosure: self.loadWord)
            levelCompleted =  true
        }
        
    }
    
    func loadWord() {
        wordLetterArray = [String]()
        word = ""
        maskedWord = ""
        maskedWordArray = [String]()
        
        livesRemaining = 10
        
        //  Save word into an array + string
        word = wordStrings[level]
        for letter in wordStrings[level] {
            wordLetterArray.append(String(letter))
        }
        
        print(wordLetterArray)
        print(word)
        
        for _ in 0..<wordLetterArray.count {
            maskedWord += "?"
            maskedWordArray.append("?")
        }
        
        wordLabel.text = maskedWord
    }
    
}

