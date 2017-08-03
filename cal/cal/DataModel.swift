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
    
    var agendaItems = [Date: [String]]()
    
    init() {
        self.agendaItems[Date()] = ["a", "b", "c"]
    }
    
    func getAgendaItems(day: Date) -> [String] {
        let values = agendaItems[day]
        if (values == nil) {
            return ["No Events"]
        } else {
            return values!
        }
    }
    
    func setAgendaItems(day: Date, items: [String]) {
        self.agendaItems[day] = items
    }


}

// This is perhaps at the wrong place. Put it in the correct file
extension UILabel {
    func createCopy() -> UILabel {
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: self)
        return NSKeyedUnarchiver.unarchiveObject(with: archivedData) as! UILabel
    }
}


extension Date {
    func getMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let strMonth = dateFormatter.string(from: self)
        return strMonth
    }
}
