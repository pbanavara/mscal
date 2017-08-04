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
}
