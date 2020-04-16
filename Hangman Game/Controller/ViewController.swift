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
    
    
    //  Array for all words + letters
    var wordLetterArray = [String]()
    var word = ""
    
    var maskedWord = ""
    var maskedWordArray = [String]()
    
    var wordStrings = [String]()
    var level = 1
    var levelCompleted = false
    
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
    
    
    //MARK: - Storyboard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        title = "Hangman ☠️"
        navigationController?.navigationBar.prefersLargeTitles =  true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clue", style: .plain, target: self, action: #selector(giveClue))
        
        loadGame()
    }
    
    @objc func giveClue() {
        
        // IF LETTER IS NOT USED
        guard let randomElement = wordLetterArray.randomElement()?.capitalized else { return }
        let wordLen = wordLetterArray.count
        
        showAlertAction(title: "🕵️", message: "The current word is \(wordLen) characters, have you considered using the letter '\(randomElement)'?", actionClosure: {})
        
        score -= 1
        livesRemaining -= 1
    }
    
    
    @IBAction func letterTapped(_ sender: UIButton) {
        guard let letterChosen = sender.currentTitle?.lowercased() else { return }
        
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

//MARK: - UIViewController Extensions

extension ViewController {
    
    func showAlertAction(title: String, message: String, actionTitle: String = "OK", actionClosure: @escaping () -> Void){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: actionTitle, style: .default, handler: {(action: UIAlertAction!) in actionClosure()}))
        self.present(ac, animated: true, completion: nil)
    }
    
}
