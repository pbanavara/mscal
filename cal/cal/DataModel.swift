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
        dateFormatter.dateFormat = "MMMM yyyy"
        let strMonth = dateFormatter.string(from: self)
        return strMonth
    }
}

//Deque for the tableview implementation
public struct Deque<T> {
    private var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func enqueueFront(_ element: T) {
        array.insert(element, at: 0)
    }
    
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            //return array.removeFirst()
            return array.first
        }
    }
    
    public mutating func dequeueRemove() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
            //return array.first
        }
    }

    
    public mutating func dequeueBack() -> T? {
        if isEmpty {
            return nil
        } else {
            //return array.removeLast()
            return array.last
        }
    }
    
    public mutating func dequeueBackRemove() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeLast()
            //return array.last
        }
    }
    
    
    public func peekFront() -> T? {
        return array.first
    }
    
    public func peekBack() -> T? {
        return array.last
    }
    
    public func getAtIndex(ind: Int) -> T? {
        if !isEmpty {
            return array[ind]
        } else {
            return nil
        }
        
    }
}
