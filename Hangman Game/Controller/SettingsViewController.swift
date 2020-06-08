//
//  SettingsViewController.swift
//  Hangman Game
//
//  Created by Ben Clarke on 22/04/2020.
//  Copyright © 2020 Ben Clarke. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var soundFXLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var soundFXSwitch: UISwitch!
    
    let defaults = UserDefaults.standard
    var soundFXOn = true
    var currentVolume: Float = 1.0
    
    var player: AVAudioPlayer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = K.settingsVCName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(goToGameScreen))
        
        volumeLabel.alpha = 0
        soundFXLabel.alpha = 0
        
        UIView.animate(withDuration: 1.0) {
            self.volumeLabel.alpha = 1.0
            self.soundFXLabel.alpha = 1.0
        }
        
        soundFXOn = defaults.bool(forKey: "SoundFX")
        currentVolume = defaults.float(forKey: "Volume")
        
        soundFXSwitch.setOn(soundFXOn, animated: true)
        volumeSlider.setValue(currentVolume, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = " "
    }
        
    @IBAction func soundFXSwitch(_ sender: UISwitch) {
        if sender.isOn == true {
            defaults.set(true, forKey: "SoundFX")
            playButtonSound()
        } else {
            defaults.set(false, forKey: "SoundFX")
        }
    }
    
    
    @IBAction func volumeChanged(_ sender: Any) {
        defaults.set(volumeSlider.value, forKey: "Volume")
    }
    
    private func playButtonSound() {
        MusicPlayer.sharedHelper.playSound(soundURL: K.Audio.buttonPressedSound)
    }
    
    @objc func goToGameScreen() {
        performSegue(withIdentifier: K.gameSeugue, sender: self)
    }
    
    private func formatUI() {
        view.backgroundColor = UIColor(named: K.Colours.bgColour)
        volumeLabel.font = UIFont(name: K.Fonts.retroGaming, size: 20.0)
        soundFXLabel.font = UIFont(name: K.Fonts.retroGaming, size: 20.0)
        volumeLabel.textColor = UIColor(named: K.Colours.labelColour)
        soundFXLabel.textColor = UIColor(named: K.Colours.labelColour)
        
        volumeSlider.tintColor = UIColor(named: K.Colours.buttonColour)
        soundFXSwitch.onTintColor = UIColor(named: K.Colours.buttonColour)
        soundFXSwitch.tintColor = UIColor(named: K.Colours.buttonColour)
    }
    
}
