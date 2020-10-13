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

extension GameViewController {
    
    func showAlertAction(title: String, message: String, actionTitle: String = "OK", actionClosure: @escaping () -> Void){
        DispatchQueue.main.async {
            [weak self] in
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: actionTitle, style: .default, handler: {(action: UIAlertAction!) in actionClosure()}))
            ac.formatUI()
            self?.present(ac, animated: true, completion: nil)
        }
    }
    
}

//MARK: - UIButton Extensions
extension UIButton {
    
    // Button formatting
    func setRoundBtnShadow() {
        self.layer.backgroundColor = UIColor.red.cgColor
        self.layer.cornerRadius = 8.0
        self.layer.shadowColor = UIColor.systemGray2.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.6
        self.layer.masksToBounds = false
    }
    
    // Fade in button
    func fadeInBtn(duration: Double) {
        self.alpha = 0
        
        UIView.animate(withDuration: duration) {
            self.alpha = 1.0
        }
    }
    
    // Pulsation animation
    func pulsateBtn() {
        let pulsation = CASpringAnimation(keyPath: "transform.scale")
        pulsation.duration = 0.5
        pulsation.fromValue = 0.96 //98
        pulsation.toValue = 1.0
        pulsation.autoreverses = true
        pulsation.repeatCount = 3 //.infinity
        pulsation.initialVelocity = 0.5 //0.5
        pulsation.damping = 1.0
        layer.add(pulsation, forKey: nil)
    }
    
    // Flash animation  
    func flashBtn() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.3
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        layer.add(flash, forKey: nil)
    }
    
}

//MARK: - UImageView Extensions

extension UIImageView {
    // Fade in img
    func animateImg(duration: Double) {
        self.alpha = 0
        UIView.animate(withDuration: duration) {
            self.alpha = 1.0
        }
    }
    
}

//MARK: - UILabel Extension

extension UILabel {
    // Typing animation
    func typingTextAnimation(text: String, timeInterval: Double) {
        self.text = ""
        self.alpha = 0
        var charIndex = 0.0
        
        for letter in text  {
            Timer.scheduledTimer(withTimeInterval: timeInterval * charIndex, repeats: false) { (timer) in
                self.text?.append(letter)
            }
            charIndex += 1
        }
        
        UIView.animate(withDuration: 1.0) {
            self.alpha = 1.0
        }
        
    }
}

//MARK: - UITableViewCell extensions

extension UITableViewCell {
    
    func fadeInCell() {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -10, 0)
        self.layer.transform = rotationTransform
        self.alpha = 0
        
        UIView.animate(withDuration: 1.0) {
            self.alpha = 1.0
        }
    }
}

//MARK: - UItableView Extensions

extension UITableView {
    
    func reloadWithBounceAnimation() {
        self.reloadData()
        let tableViewHeight = self.bounds.size.height
        let cells = self.visibleCells
        
        var delayCounter = 0
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        for cell in cells {
            UIView.animate(withDuration: 1.6, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            
            delayCounter += 1
        }
    }
    
    
    func reloadLeftToRight() {
        self.reloadData()
        let cells = visibleCells
        var delayCounter = 0
        
        for cell in cells {
            cell.frame.origin.x = -cell.frame.width
            
            UIView.animate(withDuration: 0.7, delay: 0.07 * Double(delayCounter), usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                cell.frame.origin.x = 0
            }, completion: nil)
            
            delayCounter += 1
        }
    }
    
}

//MARK: - UIAlertController Extension

extension UIAlertController {
    
    func formatUI(){
        guard let title = self.title else { return }
        guard let message = self.message else { return }
        
        self.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font: UIFont(name: K.Fonts.rainyHearts, size: 18)!]), forKey: "attributedMessage")
        self.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont(name: K.Fonts.retroGaming, size: 18.0)!]), forKey: "attributedTitle")
        //self.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.darkGray
        self.view.tintColor = UIColor(named: K.Colours.buttonColour)
    }
    
    
}
