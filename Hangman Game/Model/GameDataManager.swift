//
//  GameManager.swift
//  Hangman Game
//
//  Created by Ben Clarke on 08/01/2021.
//  Copyright © 2021 Ben Clarke. All rights reserved.
//

import UIKit

protocol GameProtocol: AnyObject {
    func gameDataFetched(_ data: [String])
}

class GameDataManager {
    
    weak var delegate: GameProtocol?
    
    func fetchData() {
        var wordStrings = [String]()
        
        if let fileURL = Bundle.main.url(forResource: K.wordsURL.fileName, withExtension: K.wordsURL.fileExtension) {
            if let wordContents = try? String(contentsOf: fileURL) {
                var lines = wordContents.components(separatedBy: "\n")
                
                lines.shuffle()
                wordStrings += lines
            }
        } else {
            fatalError("No words found!")
        }
        
        delegate?.gameDataFetched(wordStrings)
    }
    
}
