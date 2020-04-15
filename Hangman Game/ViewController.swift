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
    
    var level = 1
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
        title = "Hangman ๅ"
        navigationController?.navigationBar.prefersLargeTitles =  true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clue", style: .plain, target: self, action: #selector(giveClue))
        
        loadLevel()
    }
    
    @objc func giveClue() {
        
        let randomElement = wordLetterArray.randomElement()?.capitalized
        // Give element and make them loose a point!
        print("Clue tapped!")
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
    }
    
    func loadLevel() {
        // Read data from disk on BG thread
        var wordStrings = [String]()
        
        if let fileURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let wordContents = try? String(contentsOf: fileURL) {
                var lines = wordContents.components(separatedBy: "\n")
                lines.shuffle()
                wordStrings += lines
            }
        }
        
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
    
    
    func checkToSeeIfCompleted() {
        if livesRemaining > 0 {
            
            if maskedWord == word {
              print("completed it mate")
            }

        } else {
            print("Game ended")
            // Restart by loading game again, or consider
        }
        
        
    }

}

extension ViewController {
    
    func acPopUpController(title: String, message: String, actionTitle: String = "OK") {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        ac.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil)) // Consider adding a handler incase someone wants to restart
        present(ac, animated: true)
    }
    
    
}
