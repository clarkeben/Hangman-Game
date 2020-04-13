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
    
    var wordStrings = [String]()
    var level = 1
    var word = ""
    var usedLetters = [String]()
    var promtWord = ""
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
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
        // Create func to show one letter..
        print("Clue tapped!")
    }
    
    
    @IBAction func letterTapped(_ sender: UIButton) {
        guard let letter = sender.titleLabel?.text else { return }
        usedLetters.append(letter)
        checkLetter()
    }
    
    func loadLevel() {
        // Read data from disk on BG thread
        if let fileURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let wordContents = try? String(contentsOf: fileURL) {
                var lines = wordContents.components(separatedBy: "\n")
                lines.shuffle()
                wordStrings += lines
            }
        }
        
        word = String(wordStrings[level]).trimmingCharacters(in: .whitespacesAndNewlines)
        print(word)
        checkLetter()
    }
    
    func checkLetter() {
        for letter in 0..<(word.count) {
            let strLetter = String(letter)
            
            if usedLetters.contains(strLetter) {
                promtWord += strLetter
            } else {
                promtWord += "?"
            }
        }
        
        wordLabel.text = promtWord
    }
    
    
    
}

