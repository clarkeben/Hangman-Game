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
    
    
    func playBGMusic(playBGMusic: Bool, volume: Float) {
        let bgMusicURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: K.Audio.bgMusic, ofType: "mp3")!)
        
        if playBGMusic {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: bgMusicURL as URL)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                audioPlayer?.volume = volume
            } catch {
                print("Issue playing file")
            }
        } else {
            return
        }
    }
    
    func playSound(soundURL: String, playFXSound: Bool) {
        
        let soundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: soundURL, ofType: "mp3")!)
        
        if playFXSound {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL as URL)
                audioPlayer?.numberOfLoops = 0
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                print("Error playing FX Sounds")
            }
            
        } else {
            return
        }
        
    }
}


/* import AVFoundation  //import at the top
 
 var player: AVAudioPlayer?  //declare in code
 
 MusicHelper.sharedHelper.playBackgroundMusic() //paste in viewDidLoad
 */
