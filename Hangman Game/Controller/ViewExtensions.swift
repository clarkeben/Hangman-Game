//
//  ViewExtensions.swift
//  Hangman Game
//
//  Created by Ben Clarke on 17/04/2020.
//  Copyright © 2020 Ben Clarke. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UIViewController Extensions

extension ViewController {
    
    func showAlertAction(title: String, message: String, actionTitle: String = "OK", actionClosure: @escaping () -> Void){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: actionTitle, style: .default, handler: {(action: UIAlertAction!) in actionClosure()}))
        self.present(ac, animated: true, completion: nil)
    }
    
}

//MARK: - UIButton Extensions
extension UIButton {
    
    // Modify to meet sketch designs
    func setRoundBtnShadow() {
        self.layer.backgroundColor = UIColor.red.cgColor
        self.layer.cornerRadius = 8.0
        self.layer.shadowColor = UIColor.systemGray2.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.6
        self.layer.masksToBounds = false
    }
    
}

//MARK: - UImageView Extensions

extension UIImageView {
    
    func animateImg(duration: Double) {
        self.alpha = 0
        UIView.animate(withDuration: duration) {
            self.alpha = 1.0
        }
    }
    
}

//MARK: - UILabel Extension

extension UILabel {
    
    func typingTextAnimation(text: String) {
        self.text = ""
        self.alpha = 0
        var charIndex = 0.0
        
        for letter in text  {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.text?.append(letter)
            }
            charIndex += 1
        }
        
        UIView.animate(withDuration: 1.0) {
            self.alpha = 1.0
        }
        
    }
    
    
}

