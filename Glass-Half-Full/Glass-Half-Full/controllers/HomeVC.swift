//
//  HomeVC.swift
//  Glass-Half-Full
//
//  Created by XCodeClub on 2020-05-04.
//  Copyright © 2020 Tyler Ciarmataro. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    // VC outlets
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var currentCupsLabel: UILabel!
    
    // VC properties
    var target:Int = 8 //set to default if the user hasn't set a custom target
    let defaults = UserDefaults.standard
    var daysList : [Day] = []
    var currentDate: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentDate = getCurrentDate()
        
        //try to load days array
        if defaults.object(forKey: "waterData") as? Data ?? nil == nil {
            // no waterHistory exists
            
            // create test days DEBUG ONLY DELETE BEFORE SUBMISSION
            addMockData()
            
            // have to create a day and add it to daysList
            daysList.append(Day())
            saveDays()
        } else {
            // waterHistory exists so decode it and set it to daysList
            if let savedDays = defaults.object(forKey: "waterData") as? Data {
                let decoder = JSONDecoder()
                if let loadedDays = try? decoder.decode([Day].self, from: savedDays) {
                    daysList = loadedDays
                }
            }
            
            // check to see if current day exists in the array already
            let existingIndex = daysList.firstIndex(where: {$0.date == currentDate}) ?? -1
        
            // if it doesn't create a day and set currentDay
            if existingIndex == -1 {
                daysList.append(Day())
                saveDays()
            }
        }
        
        //print("\(currentDay!.date) \(currentDay!.cups)")
        currentCupsLabel!.text = "\(daysList[daysList.firstIndex(where: {$0.date == currentDate})!].cups)"
    }
    
    // runs whenever we open the home page
    override func viewDidAppear(_ animated: Bool) {
        // load the target from UserDefaults
        if defaults.integer(forKey: "target") != 0 {
            target = defaults.integer(forKey: "target")
        }
        targetLabel!.text = "\(target)"
        
        // if current day doesn't exist, create a new day
    }
    
    // user presses button to add a cup
    @IBAction func addCup(_ sender: Any) {
        daysList[daysList.firstIndex(where: {$0.date == currentDate})!].addCup()
        print("Added, cups is now \(daysList[daysList.firstIndex(where: {$0.date == currentDate})!].cups)")
        currentCupsLabel!.text = "\(daysList[daysList.firstIndex(where: {$0.date == currentDate})!].cups)"
        saveDays()
    }
    
    //user presses a button to subtract a cup
    @IBAction func subtractCup(_ sender: Any) {
        daysList[daysList.firstIndex(where: {$0.date == currentDate})!].subtractCup()
        print("Subtracted, cups is now \(daysList[daysList.firstIndex(where: {$0.date == currentDate})!].cups)")
        currentCupsLabel!.text = "\(daysList[daysList.firstIndex(where: {$0.date == currentDate})!].cups)"
        saveDays()
    }
    
    // returns the current formatted date to check waterHistory
    func getCurrentDate() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        formatter.timeZone = TimeZone.current
        return formatter.string(from: currentDate) //formatted current date
    }
    
    func saveDays() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(daysList){
           defaults.set(encoded, forKey: "waterData")
           print("saved data")
        }
    }
    
    func addMockData() {
        print("Adding mock data...")
        
        let testDay1 = Day()
        testDay1.date = "4/28/20"
        testDay1.cups = 5
        daysList.append(testDay1)
        
        let testDay2 = Day()
        testDay2.date = "4/29/20"
        testDay2.cups = 2
        daysList.append(testDay2)
        
        let testDay3 = Day()
        testDay3.date = "4/30/20"
        testDay3.cups = 8
        daysList.append(testDay3)
        
        let testDay4 = Day()
        testDay4.date = "5/1/20"
        testDay4.cups = 9
        daysList.append(testDay4)
        
        let testDay5 = Day()
        testDay5.date = "5/2/20"
        testDay5.cups = 3
        daysList.append(testDay5)
        
        let testDay6 = Day()
        testDay6.date = "5/3/20"
        testDay6.cups = 1
        daysList.append(testDay6)
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
