//
//  WelcomeViewController.swift
//  Hangman Game
//
//  Created by Ben Clarke on 17/04/2020.
//  Copyright © 2020 Ben Clarke. All rights reserved.
//

import UIKit
import AVFoundation

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var howToPlayBtn: UIButton!
    
    var player: AVAudioPlayer?
    
    let defaults = UserDefaults.standard
    var totalScore = 0 {
        didSet {
            totalScoreLabel.text = "Total Score: \(totalScore)"
        }
    }
    var soundFXOn = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
        if let score = defaults.integer(forKey: K.scoreKey) as? Int {
            totalScore = score
        } else {
            totalScore = 0
        }
        
        if let soundFXStatus = defaults.bool(forKey: K.Audio.fxSoundKey) as? Bool {
            soundFXOn = soundFXStatus
        } else {
            soundFXOn = true
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the  line below if you want to play Background music
        // MusicPlayer.sharedHelper.playBGMusic()
        
        // Button animations 
        titleLabel.typingTextAnimation(text: K.appName, timeInterval: 0.1)
        playBtn.fadeInBtn(duration: 1.0)
        settingsBtn.fadeInBtn(duration: 1.0)
        howToPlayBtn.fadeInBtn(duration: 1.0)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func playBtnPressed(_ sender: Any) {
        playButtonSound()
        performSegue(withIdentifier: K.gameSeugue, sender: self)
    }
    
    @IBAction func settingsBtnPressed(_ sender: Any) {
        playButtonSound()
        performSegue(withIdentifier: K.settingsSegue, sender: self)
    }
    
    @IBAction func howToPlayPressed(_ sender: Any) {
        playButtonSound()
        performSegue(withIdentifier: K.howToPlaySegue, sender: self)
    }
    
    
    func playButtonSound() {
        MusicPlayer.sharedHelper.playSound(soundURL: K.Audio.buttonPressedSound)
    }
    
    
    
}
