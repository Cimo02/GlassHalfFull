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
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userNotificationCenter.delegate = self
        self.requestNotificationAuthorization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if defaults.object(forKey: "reminderTime") != nil {
            currentReminderLabel!.text = defaults.string(forKey: "reminderTime")
        }
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
    
    @IBAction func updateReminder(_ sender: Any) {
        // Create new notifcation content instance
        let notificationContent = UNMutableNotificationContent()

        // Add the content to the notification content
        notificationContent.title = "Glass Half Full"
        notificationContent.body = "This is your reminder to drink some water!"
        notificationContent.sound = UNNotificationSound.default
        notificationContent.badge = NSNumber(value: 1)
        
        // create calender object for user selected time
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: timePicker.date)
        
        let timeString = "\(dateComponents.hour!):\(dateComponents.minute!)"
        defaults.set(timeString, forKey: "reminderTime")
        currentReminderLabel!.text = timeString
        
        // add the reminder trigger
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        // create request and add it to the notification center
        let request = UNNotificationRequest(identifier: "waterNotification", content: notificationContent, trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    @IBAction func stopReminder(_ sender: Any) {
        userNotificationCenter.removeAllPendingNotificationRequests()
        defaults.set("N/A", forKey: "reminderTime")
        currentReminderLabel!.text = "N/A"
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
