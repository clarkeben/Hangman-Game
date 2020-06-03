//
//  HowToPlayTableViewController.swift
//  Hangman Game
//
//  Created by Ben Clarke on 21/04/2020.
//  Copyright © 2020 Ben Clarke. All rights reserved.
//

import UIKit

class HowToPlayTableViewController: UITableViewController {
    
    var rulesTitle = rulesData.gamesRulesTitle
    var rules = rulesData.gamesRules
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()

        navigationController?.navigationBar.isHidden = false
        
        title = K.howTopPlayVCName
        tableView.reloadWithBounceAnimation()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rules.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.rulesCellName, for: indexPath)
        
        cell.textLabel?.font = UIFont(name: K.Fonts.retroGaming, size: 20.0)
        cell.detailTextLabel?.font = UIFont(name: K.Fonts.rainyHearts, size: 20.0)
        cell.textLabel?.textColor = UIColor(named: K.Colours.labelColour)
        cell.detailTextLabel?.textColor = UIColor(named: K.Colours.labelColour)
        
        cell.textLabel?.text = rulesTitle[indexPath.row]
        cell.detailTextLabel?.text = rules[indexPath.row]
        return cell
    }
    
    
}
