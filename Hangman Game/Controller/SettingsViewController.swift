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
    
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var soundFXSwitch: UISwitch!
    
    let defaults = UserDefaults.standard
    var soundOn = true
    var soundFXOn = true
    var currentVolume: Float = 1.0
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = K.settingsVCName
        navigationController?.navigationBar.prefersLargeTitles = true
        
        soundOn = defaults.bool(forKey: "Sound")
        soundFXOn = defaults.bool(forKey: "SoundFX")
        currentVolume = defaults.float(forKey: "Volume")
        
        soundSwitch.setOn(soundOn, animated: true)
        soundFXSwitch.setOn(soundFXOn, animated: true)
        volumeSlider.setValue(currentVolume, animated: true)
    }
    

    @IBAction func soundSwitch(_ sender: UISwitch) {
        
        if sender.isOn == true {
            defaults.set(true, forKey: "Sound")
        } else {
            defaults.set(false, forKey: "Sound")
            print("Sound is off")
        }
    }
    
    @IBAction func soundFXSwitch(_ sender: UISwitch) {
        if sender.isOn == true {
            defaults.set(true, forKey: "SoundFX")
            print("Sound FX On")
        } else {
            defaults.set(false, forKey: "SoundFX")
            print("SoundFX OFF")
        }
    }
    

    @IBAction func volumeChanged(_ sender: Any) {
        defaults.set(volumeSlider.value, forKey: "Volume")
    }
    
}
