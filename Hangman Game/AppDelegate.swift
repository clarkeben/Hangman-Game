//
//  AppDelegate.swift
//  Hangman Game
//
//  Created by Ben Clarke on 09/04/2020.
//  Copyright © 2020 Ben Clarke. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (notifcationsAllowed, error) in
            if error != nil {
                print(error ?? "Error setting up notifications!!")
            }
        }
        
        scheduleNotification()
        
        setUpNavBarFormatting()
        
        return true
    }
    
    func scheduleNotification() {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Can you beat the hangman?"
        content.body = "New words await you, player!"
        content.categoryIdentifier = "reminder"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.minute = 30
        dateComponents.weekday = 6
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "weeklyAlert", content: content, trigger: trigger)
        center.add(request)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let reminder = UNNotificationAction(identifier: "reminder", title: "Play", options: .foreground)
        let dismiss = UNNotificationAction(identifier: "later", title: "Remind me later", options: .destructive)
        let category = UNNotificationCategory(identifier: "reminder", actions: [reminder, dismiss], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
    func setUpNavBarFormatting() {
        UINavigationBar.appearance().barTintColor = UIColor(named: K.Colours.bgColour)
        UINavigationBar.appearance().tintColor = UIColor(named: K.Colours.buttonColour)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                            NSAttributedString.Key.font: UIFont(name: K.Fonts.retroGaming, size: 22.0)!]
        UINavigationBar.appearance().isTranslucent = false
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: K.Fonts.retroGaming, size: 15.0)!], for: .normal)
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

