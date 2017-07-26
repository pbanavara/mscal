//
//  data.swift
//  cal
//
//  Created by pbanavara on 7/26/17.
//  Copyright © 2017 pbanavara. All rights reserved.
//

import Foundation

class DataModel {
    
    let days : [Int : String] = [1 : "Sunday",
                                 2 : "Monday",
                                 3 : "Tuesday",
                                 4 : "Wednesday",
                                 5 : "Thursday",
                                 6 : "Friday",
                                 7 : "Saturday"]
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
    let agendaItems : [[String: [String]]] = [["Sunday" : ["a", "b", "c"]],
                                              ["Monday": ["c", "d", "e"]],
                                              ["Tuesday" : ["a", "b", "c"]],
                                              ["Wednesday" : ["a", "b", "c"]],
                                              ["Thursday" : ["a", "b", "c"]],
                                              ["Friday" : ["a", "b", "c"]],
                                              ["Saturday" : ["a", "b", "c"]],
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
    
    
}
