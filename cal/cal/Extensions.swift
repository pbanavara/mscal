//
//  Extensions.swift
//  cal
//
//  Created by pbanavara on 8/4/17.
//  Copyright © 2017 pbanavara. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func createCopy() -> UILabel {
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: self)
        return NSKeyedUnarchiver.unarchiveObject(with: archivedData) as! UILabel
    }
}


extension Date {
    func getMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        let strMonth = dateFormatter.string(from: self)
        return strMonth
    }
    
    func getFirstDayOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        let startOfMonth = Calendar.current.date(from: components)
        return startOfMonth!
    }
    
}

extension UIColor {
    static func appleBlue() -> UIColor {
        return UIColor.init(colorLiteralRed: 14.0/255, green: 122.0/255, blue: 254.0/255, alpha: 1.0)
    }
}
