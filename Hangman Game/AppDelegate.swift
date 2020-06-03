//
//  AppDelegate.swift
//  Hangman Game
//
//  Created by Ben Clarke on 09/04/2020.
//  Copyright © 2020 Ben Clarke. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        
        /*UINavigationBar.appearance().titleTextAttributes = [
         NSAttributedString.Key.foregroundColor: UIColor(named: K.Colours.labelColour),
         NSAttributedString.Key.font: UIFont(name: K.Fonts.retroGaming, size: 27.0)!
         ]
         UINavigationBar.appearance().backgroundColor = UIColor(named: K.Colours.bgColour)
         UINavigationBar.appearance().barTintColor = UIColor(named: K.Colours.bgColour)
         UINavigationBar.appearance().isTranslucent = false*/
        
        UINavigationBar.appearance().barTintColor = UIColor(named: K.Colours.bgColour)
        UINavigationBar.appearance().tintColor = UIColor(named: K.Colours.buttonColour)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                            NSAttributedString.Key.font: UIFont(name: K.Fonts.retroGaming, size: 27.0)!]
        UINavigationBar.appearance().isTranslucent = false
        
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

