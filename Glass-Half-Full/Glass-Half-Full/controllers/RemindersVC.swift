//
//  RemindersVC.swift
//  Glass-Half-Full
//
//  Created by XCodeClub on 2020-05-04.
//  Copyright © 2020 Tyler Ciarmataro. All rights reserved.
//

import UIKit
import UserNotifications

class RemindersVC: UIViewController, UNUserNotificationCenterDelegate {
    let userNotificationCenter = UNUserNotificationCenter.current()
    @IBOutlet weak var currentReminderLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userNotificationCenter.delegate = self
        
        self.requestNotificationAuthorization()
        //self.sendNotification()
        // Do any additional setup after loading the view.
    }
    
    func requestNotificationAuthorization() {
        // Auth options
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        
        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }
    
    func sendNotification() {
        
    }
    
    @IBAction func updateReminder(_ sender: Any) {
        // Create new notifcation content instance
        let notificationContent = UNMutableNotificationContent()

        // Add the content to the notification content
        notificationContent.title = "Glass Half Full"
        notificationContent.body = "This is your reminder to drink some water!"
        notificationContent.sound = UNNotificationSound.default
        notificationContent.badge = NSNumber(value: 1)
        
        // add the reminder trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60,
        repeats: true)
        // create request and add it to the notification center
        let request = UNNotificationRequest(identifier: "waterNotification", content: notificationContent, trigger: trigger)
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
