//
//  data.swift
//  cal
//
//  Created by pbanavara on 7/26/17.
//  Copyright © 2017 pbanavara. All rights reserved.
//

import Foundation
import UIKit

class DataModel {
    
    
    let days : [Int : String] = [1 : "Sunday",
                                 2 : "Monday",
                                 3 : "Tuesday",
                                 4 : "Wednesday",
                                 5 : "Thursday",
                                 6 : "Friday",
                                 7 : "Saturday",
                                 8 : "Dummy",
                                 9 : "Dummy",
                                 10 : "Dummy"]
    let months : [Int : String] = [1: "January",
                                   2 : "February",
                                   3 : "March",
                                   4 : "April",
                                   5 : "May",
                                   6 : "June",
                                   7 : "July",
                                   8 : "August",
                                   9 : "September",
                                   10 : "October",
                                   11 : "November",
                                   12 : "December"]
    var agendaItems : [[String: [String]]] = [["Sunday" : ["a", "b", "c"]],
                                              ["Monday": ["c", "d", "e"]],
                                              ["Tuesday" : ["a", "b", "c"]],
                                              ["Wednesday" : ["a", "b", "c"]],
                                              ["Thursday" : ["a", "b", "c"]],
                                              ["Friday" : ["a", "b", "c"]],
                                              ["Saturday" : ["a", "b", "c"]],
                                              ["Boomday" : ["a", "b", "c"]],
                                              ["Boomday" : ["a", "b", "c"]],
                                              ["Boomday" : ["a", "b", "c"]],
                                              ["Boomday" : ["a", "b", "c"]],
                                              ["Boomday" : ["a", "b", "c"]]]
    
    func getDay(day: Int) -> String {
        return days[day]!
    }
    
    func getMonth(month: Int) -> String {
        return months[month]!
    }
    
    func getAgendaItems() -> [[String : [String]]] {
        return agendaItems
    }
    
    func setAgendaItems(items : [[String: [String]]]) {
        self.agendaItems = items
    }


}

// This is perhaps at the wrong place. Put it in the correct file
extension UILabel {
    func createCopy() -> UILabel {
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: self)
        return NSKeyedUnarchiver.unarchiveObject(with: archivedData) as! UILabel
    }
}
