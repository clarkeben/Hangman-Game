//
//  MusicPlayer.swift
//  Hangman Game
//
//  Created by Ben Clarke on 23/04/2020.
//  Copyright © 2020 Ben Clarke. All rights reserved.
//

import Foundation
import AVFoundation

class MusicPlayer {
    
    static let sharedHelper = MusicPlayer()
    var audioPlayer: AVAudioPlayer?
    
    let defaults = UserDefaults.standard
    lazy var soundOn = defaults.object(forKey: K.Audio.bgMusicKey) as? Bool ?? true
    lazy var fxSoundOn = defaults.object(forKey: K.Audio.fxSoundKey) as? Bool ?? true
    lazy var volume = defaults.object(forKey: K.Audio.volumeKey) as? Float ?? 1.0
    
    
    func playBGMusic() {
        let bgMusicURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: K.Audio.bgMusic, ofType: "mp3")!)
        
        if soundOn {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: bgMusicURL as URL)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                audioPlayer?.volume = volume
                print("playing music")
            } catch {
                print("Issue playing file")
            }
        } else {
            audioPlayer?.stop()
            return
        }
    }
    
    func playSound(soundURL: String) {
        
        let soundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: soundURL, ofType: "wav")!)
        
        if fxSoundOn {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL as URL)
                audioPlayer?.numberOfLoops = 0
                audioPlayer?.prepareToPlay()
                audioPlayer?.volume = 0.3
                audioPlayer?.play()
            } catch {
                print("Error playing FX Sounds")
            }
            
        } else {
            audioPlayer?.stop()
            return
        }
        
    }
}
