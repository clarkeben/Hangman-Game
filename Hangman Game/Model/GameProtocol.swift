//
//  GameProtocol.swift
//  Hangman Game
//
//  Created by Ben Clarke on 08/01/2021.
//  Copyright © 2021 Ben Clarke. All rights reserved.
//

import UIKit

protocol GameProtocol: AnyObject {
    func gameDataFetched(_ data: [String])
}
