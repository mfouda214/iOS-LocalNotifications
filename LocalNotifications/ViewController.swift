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

class ViewController: UIViewController {
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var delayValue: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var setNotificationButton: UIButton!
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    var imageName: String! {
        didSet {
            print(imageName)
        }
    }
    
    var delay:Float = 6.0 {
        didSet {
            delayValue.text =  String(format: "%.1f", delay)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeSlider()
        segmentedControlValueChanged(segmentedControl)
        
        requestNotificationsAuthorization()
        
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        setImageName(from: sender)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        delay = sender.value
    }
    
    @IBAction func setNotificationTapped(_ sender: UIButton) {
        showNotification()
    }
    
    
    // MARK: Helper
    private func setImageName(from segmentedControl:UISegmentedControl) {
        let index = segmentedControl.selectedSegmentIndex
        imageName = segmentedControl.titleForSegment(at: index)!.lowercased()
    }
    
    private func initializeSlider() {
        slider.minimumValue = 2.0
        slider.maximumValue = 12.0
        delay = slider.value
    }
    
    private func requestNotificationsAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) {[weak self] (granted, error) in
            if let error = error {
                self?.showAlert(message: "Error requesting UserNotification authorization: \(error)")
            }
        }
    }
    
    private func showNotification() {
        checkNotificationsAuthorizationStatus()
        let content = UNMutableNotificationContent()
        content.title = "Congratulation"
        content.body = "This car is waiting for you at showroom nearby"
        content.sound = UNNotificationSound.default()
        content.badge = 1
        content.categoryIdentifier = "OverdueTasksCategory"
        
        let attachment = createNotificationAttachment()
        content.attachments = [attachment]
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(delay), repeats: false)
        
        let request = UNNotificationRequest(identifier: "CoolCarNotification", content: content, trigger: trigger)
        
        notificationCenter.add(request) {[weak self] (error) in
            if let error = error {
                self?.showAlert(message: "Couldn't add notification. Error: \(error)")
            }
        }
    }
    
    private func checkNotificationsAuthorizationStatus() {
        notificationCenter.getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .denied, .notDetermined:
                self.showAlert(message: "Please enable Notification from Settings")
            case .authorized:
                break
            }
        }
    }
    
    private func createNotificationAttachment() -> UNNotificationAttachment {
        let url = Bundle.main.url(forResource: imageName, withExtension: "jpg")!
        return try! UNNotificationAttachment(identifier: "image", url: url, options: [:])
    }
    
    
}

