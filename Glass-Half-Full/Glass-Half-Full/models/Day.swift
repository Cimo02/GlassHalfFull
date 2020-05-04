//
//  Day.swift
//  Glass-Half-Full
//
//  Created by XCodeClub on 2020-05-04.
//  Copyright © 2020 Tyler Ciarmataro. All rights reserved.
//

import Foundation

class Day: Codable {
    var date: String
    var cups: Int
    
    init(){
        // create date automatically for the current date on init
        let fullDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        formatter.timeZone = TimeZone.current
   
        self.date = formatter.string(from: fullDate) //formatted date
        self.cups = 0 // new day so there won't be any cups drank yet
    }
    
    func addCup() {
        cups += 1
    }

    func subtractCup() {
        if cups > 0 {
            cups -= 1
        }
    }
}
