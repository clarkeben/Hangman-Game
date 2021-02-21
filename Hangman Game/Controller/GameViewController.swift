//
//  ViewController.swift
//  Hangman Game
//
//  Created by Ben Clarke on 09/04/2020.
//  Copyright © 2020 Ben Clarke. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController, GameProtocol {
   
    @IBOutlet weak var hangmanImgView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var guessesRemainingLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    var player: AVAudioPlayer?
    
    let defaults = UserDefaults.standard
    var totalScore = 0 {
        didSet {
            defaults.set(totalScore, forKey: K.scoreKey)
        }
    }
    
    let gameManager = GameDataManager()
    var wordLetterArray = [String]()
    var word = ""
    
    var maskedWord = ""
    var maskedWordArray = [String]()
    
    var wordStrings = [String]()
    var level = 0
    var levelCompleted = false
    var usedLetters = ""
    
    var hangmanImgNumber = 0 {
        didSet {
            hangmanImgView.image = UIImage(named: "\(K.hangmanImg)\(hangmanImgNumber)")
        }
    }
    
    var score = 0 {
        didSet {
            scoreLabel.text = "\(score) points"
        }
    }
    
    var livesRemaining = 10 {
        didSet {
            guessesRemainingLabel.text = "\(livesRemaining) lives left"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = K.appName
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clue", style: .plain, target: self, action: #selector(giveClue))
        
        gameManager.delegate = self
        
        gameManager.fetchData()
        
        totalScore = defaults.integer(forKey: K.scoreKey)
        
        formatUI()
    }
        
    @objc func giveClue() {
        
        let filteredLetters = wordLetterArray.filter { !$0.contains(usedLetters) }
        guard let randomElement = filteredLetters.randomElement()?.capitalized else { return }
        
        let wordLen = wordLetterArray.count
        
        showAlertAction(title: "🕵️", message: "The current word is \(wordLen) characters, have you considered using the letter '\(randomElement)'?", actionClosure: {})
        
        score -= 1
        livesRemaining -= 1
        hangmanImgNumber += 1
        
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
            totalScore += 1
            playSound(sound: K.Audio.correctAnswerSound)
            
        } else {
            score -= 1
            totalScore -= 1
            hangmanImgNumber += 1
            livesRemaining -= 1
            playSound(sound: K.Audio.wrongAnswerSound)
        }
        
        sender.isEnabled = false
        sender.setTitleColor(UIColor(named: K.Colours.buttonColour), for: .disabled)
        wordLabel.text = maskedWord
        
        // check to see if the game is completed + reset
        checkToSeeIfCompleted()
        
        if livesRemaining <= 1 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
        if levelCompleted {
            for button in letterButtons {
                button.isEnabled = true
                navigationItem.rightBarButtonItem?.isEnabled = true
            }
            levelCompleted = false
        }        
    }
    
    
    func gameDataFetched(_ data: [String]) {
        wordStrings += data
        loadWord()
    }
    
    
    func checkToSeeIfCompleted() {
        
        if livesRemaining > 0 {
            if maskedWord == word {
//                showAlertAction(title: "Congratulations 🎉", message: "You've beat the hangman!", actionTitle: "Restart", actionClosure: self.loadWord)
                
                gameFinishedAlert(title: "Congratulations 🎉", message: "You've beat the hangman!", word: word, actionTitle: "Restart", actionClosure: self.loadWord)
                
                playSound(sound: K.Audio.gameWonSound)
                nextLevel()
            }
            
        } else {
            //showAlertAction(title: "💀", message: "The hangman caught you, the word was \"\(word.uppercased())\"!", actionTitle: "Restart", actionClosure: self.loadWord)
            
            gameFinishedAlert(title: "💀", message: "The hangman caught you, the word was \"\(word.uppercased())\"!", word: word, actionTitle: "Restart", actionClosure: self.loadWord)
            
            nextLevel()
        }
        
    }
    
    func loadWord() {
        
        wordLetterArray = [String]()
        word = ""
        maskedWord = ""
        maskedWordArray = [String]()
        
        livesRemaining = 10
        hangmanImgNumber = 0
        
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
        wordLabel.typingTextAnimation(text: maskedWord, timeInterval: 0.2)
    }
    
    func nextLevel() {
        level += 1
        levelCompleted = true
    }
    
    func playSound(sound: String) {
        MusicPlayer.sharedHelper.playSound(soundURL: sound)
    }
    
    private func formatUI(){
        view.backgroundColor = UIColor(named: K.Colours.bgColour)
        
        hangmanImgView.image = UIImage(named: "\(K.hangmanImg)\(hangmanImgNumber)")
        scoreLabel.text = "0 points"
        scoreLabel.font = UIFont(name: K.Fonts.rainyHearts, size: 20.0)
        scoreLabel.textColor = UIColor(named: K.Colours.bgColour)
        scoreLabel.backgroundColor = UIColor(named: K.Colours.highlightColour)
        guessesRemainingLabel.font = UIFont(name: K.Fonts.rainyHearts, size: 20.0)
        wordLabel.font = UIFont(name: K.Fonts.retroGaming, size: 36.0)
        
        for button in letterButtons {
            button.titleLabel?.font = UIFont(name: K.Fonts.retroGaming, size: 24.0)
            button.setTitleColor(UIColor(named: K.Colours.labelColour), for: .normal)
        }
    }
    
}

