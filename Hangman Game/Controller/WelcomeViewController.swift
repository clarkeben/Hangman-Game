//
//  WelcomeViewController.swift
//  Hangman Game
//
//  Created by Ben Clarke on 17/04/2020.
//  Copyright © 2020 Ben Clarke. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        // Animate logo
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    
    
        
}
