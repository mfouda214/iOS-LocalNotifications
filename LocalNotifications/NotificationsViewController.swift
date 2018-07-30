//
//  ViewController.swift
//  LocalNotifications
//
//  Updated by Mohamed Sobhi Fouda on 7/30/18.
//  Created by Hesham Abd-Elmegid on 3/7/17.
//  Copyright © 2017 CareerFoundry. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationsViewController: UIViewController {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    @IBAction func requestNotificationsAuthorization(_ sender: Any) {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge];
        
        notificationCenter.requestAuthorization(options: options) { (granted, error) in
            if granted {
                print("Accepted permission.")
            } else {
                print("Did not accept permission.")
            }
        }
    }
    
    @IBAction func checkNotificationsAuthorizationStatus(_ sender: Any) {
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                print("Notifications are authorized")
                
                if (settings.soundSetting == .disabled) {
                    print("Sound is disabled")
                }
            } else if settings.authorizationStatus == .denied {
                print("Notifications have been denied")
            } else {
                print("Notifications authorization dialog hasn't been shown yet")
            }
        }
    }
    
    @IBAction func showNotification(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Overdue Tasks"
        content.body = "You have 5 overdue tasks"
        content.sound = UNNotificationSound.default()
        content.badge = 5
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: "OverdueTasksNotification", content: content, trigger: trigger)
        
        notificationCenter.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("Couldn't add notification. Error: \(error)")
            }
        })
    }
}
