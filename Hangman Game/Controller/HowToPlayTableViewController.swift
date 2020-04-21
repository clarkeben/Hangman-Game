//
//  HowToPlayTableViewController.swift
//  Hangman Game
//
//  Created by Ben Clarke on 21/04/2020.
//  Copyright © 2020 Ben Clarke. All rights reserved.
//

import UIKit

class HowToPlayTableViewController: UITableViewController {
    
    var rules = K.rules.gamesRules
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        
        title = K.howTopPlayVCName
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.reloadWithAnimation()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rules.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.rules.cellName, for: indexPath)
        cell.textLabel?.text = rules[indexPath.row]
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//        //cell.fadeInCell()
//    }
    
}
