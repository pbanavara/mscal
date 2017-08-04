//
//  ViewController.swift
//  cal
//
//  Created by pbanavara on 7/22/17.
//  Copyright © 2017 pbanavara. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,
                        UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var calendarView: UICollectionView!
    @IBOutlet weak var agendaView: UITableView!
    
    @IBOutlet weak var header: UICollectionView!
    //Constants
    let calendarViewCellColor = UIColor.appleBlue()
    
    var dates = [Int]()
    var noOfDays = 7
    
    var dataModel = DataModel()
    var bounds = CGRect()
    var tableBounds = CGRect()
    
    //calendar variables
    var currentMonth = 0
    var nextMonth = 0
    var previousMonth = 0
    var totalDates = [[Date]]()
    
    var headerArray = ["M", "T", "W", "T", "F", "S", "S"]
    var selected = false
    
    var tableCellHeight = 1.0
    var currentDate: Date = Date()
    var deque = Deque<[Date: [String]]>()
    var dequeCounter = 8
    var lastContentOffset: CGPoint = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.dataSource = self
        calendarView.delegate = self
        agendaView.dataSource = self
        agendaView.delegate = self
        header.delegate = self
        header.dataSource = self
        bounds = calendarView.frame
        tableBounds = agendaView.frame
        let dates = getAllDates(day: Date())
        totalDates.append(dates)
        currentDate = Date()
        navBar.topItem?.title = currentDate.getMonthName()
        populateInitialTableView()
        
    }
    
    func populateInitialTableView() {
        //Get agenda items for a week starting with the current day
        
        for i in 0..<7 {
            let date = Calendar.current.date(byAdding: .day, value: i, to: currentDate)!
            let aiForDay = dataModel.getAgendaItems(day: date)
            deque.enqueue([date: aiForDay])
        }
            
    }
    
    /*
     The current, previous and next month components are currently not used.
     Had thought of as a placeholder.
     */
    func getDate() -> DateComponents {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        currentMonth = components.month!
        let nextMonthDate = Calendar.current.date(byAdding: .month, value: 1, to: date)
        nextMonth = calendar.dateComponents([.month], from: nextMonthDate!).month!
        let prevMonthDate = Calendar.current.date(byAdding: .month, value: -1, to: date)
        previousMonth = calendar.dateComponents([.month], from: prevMonthDate!).month!
        return components
    }
    
    func getAllDates(day: Date) -> [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: day)
        let dayOfMonth = calendar.component(.day, from: today)
        let days = calendar.range(of: .day, in: .month, for: today)!
        let dayrange = (days.lowerBound+1 ..< days.upperBound)
            .flatMap { calendar.date(byAdding: .day, value: $0 - dayOfMonth, to: today) }
            
        return dayrange
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //var count = dataModel.getAgendaItems(day: currentDate).count
        return 7
            
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.header) {
            return headerArray.count
        } else {
            let flattenedDates = totalDates.flatMap { $0 }
            return flattenedDates.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.calendarView) {
            let cell = calendarView.dequeueReusableCell(withReuseIdentifier: "reuseCalendarCell", for: indexPath) as! CalendarCellCollectionViewCell
            let row = indexPath.row
            let date = totalDates.flatMap { $0 }[row]
            let strDate = convertDatesToString(input: date, isShort: true)
            let strCurrentDate = convertDatesToString(input: currentDate, isShort: true)
            if(strDate == strCurrentDate) {
                cell.day_label.backgroundColor = calendarViewCellColor
            }
            let day = Calendar.current.component(.day, from: date)
            cell.day_label.text = String(day)
            return cell
        } else {
            let cell = header.dequeueReusableCell(withReuseIdentifier: "reuseHeaderCell", for: indexPath) as! HeaderCollectionViewCell
            cell.cellLabel.text = headerArray[indexPath.row]
            return cell
        }
    
    }
    
    private func calcuateDaysBetweenTwoDates(start: Date, end: Date) -> Int {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: .day, in: .era, for: start) else {
            return 0
        }
        guard let end = currentCalendar.ordinality(of: .day, in: .era, for: end) else {
            return 0
        }
        return end - start
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = calendarView.cellForItem(at: indexPath) as! CalendarCellCollectionViewCell
        //cell.day_label.backgroundColor = calendarViewCellColor
        var date = totalDates.flatMap { $0 } [indexPath.row]
        //var incrDate = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        dataModel.setAgendaItems(day: date, items: ["adsfs", "face", "new", "abs"])
        deque.enqueueFront([date: ["adsfs", "face", "new", "abs"]])
        agendaView.reloadData()
        var flattenedDates = totalDates.flatMap { $0 }
        let ind = indexPath.row
        flattenedDates.remove(at: ind)
        cell.day_label.backgroundColor = calendarViewCellColor
        
        //hack for some reason on every iteration one element in the dequeue is not deleted
        deque.empty()
        
        // Always maintain 8 elements in the dequeue since we are storing all the agenda items in a
        // separate dictionary
        for _ in 0..<7 {
            let newItem = dataModel.getAgendaItems(day: date)
            deque.enqueue([date: newItem])
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
    
        agendaView.reloadData()
        
    }
    
   
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func convertDatesToString(input: Date, isShort: Bool) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        if (!isShort) {
            dateFormatter.dateStyle = DateFormatter.Style.full
        } else {
            dateFormatter.dateStyle = DateFormatter.Style.short
        }
        
        return dateFormatter.string(from: input)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = agendaView.dequeueReusableCell(withIdentifier: "agendaItem") as! AgendaTableViewCell
        let i = indexPath.row
        let agendaDetails = deque.getAtIndex(ind: i)
        let cellDate = agendaDetails?.keys.first!
        
        let strDate = convertDatesToString(input: cellDate!, isShort: false)

        cell.dayMonthLabel.text = strDate
        var count:CGFloat = 1
        for ind in agendaDetails![cellDate!]! {
            if (count > 1) {
                let agenda = cell.agendaDetails.createCopy()
                
                tableCellHeight = Double(cell.agendaDetails.frame.origin.y * count)
                agenda.frame = CGRect(x: cell.agendaDetails.frame.origin.x,
                                          y: cell.agendaDetails.frame.origin.y * count,
                                          width: cell.agendaDetails.frame.size.width,
                                          height: cell.agendaDetails.frame.size.height)
                
                agenda.text = ind
                cell.addSubview(agenda)
                cell.sizeToFit()
            } else {
                tableCellHeight = Double(cell.agendaDetails.frame.size.height * 2)
                cell.agendaDetails.text = ind
            }
            count += 1
        }
        
        //CollectionView update when a cell reaches the top row of the UITable
        if (i == 0) {
            let date = convertDatesToString(input: (deque.getAtIndex(ind: i)?.keys.first)!, isShort: true)
            let flattenedDates = totalDates.flatMap { $0 }.map { convertDatesToString(input: $0, isShort: true) }
            guard let cViewIndex = flattenedDates.index(of: date) else {
                return cell
            }
            let cViewIndexPath = IndexPath(item: cViewIndex, section: 0)
            guard let cViewCell = calendarView.cellForItem(at: cViewIndexPath) as? CalendarCellCollectionViewCell else {
                return cell
            }
            cViewCell.day_label.backgroundColor = UIColor.appleBlue()
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfDays))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfDays))
        return CGSize(width: size, height: size)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.isKind(of: UICollectionView.self) {
            // Get the first date of the current month to get previous and next months
            let firstDay = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: Date())))!
            let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: firstDay)
            let days = getAllDates(day: nextMonth!)
            totalDates.append(days)
            //Resize the collectionview height
            let newCalendarSize = CGSize(width: calendarView.collectionViewLayout.collectionViewContentSize.width, height: bounds.size.height * 2.5)
            calendarView.frame = CGRect(origin: bounds.origin, size: newCalendarSize)
            // Resize the tableview height according to the new collectionview height
            // Change the hardcoded 120
            agendaView.frame = CGRect(x: tableBounds.origin.x, y: tableBounds.origin.y + 120,
                                      width: agendaView.contentSize.width, height: tableBounds.height)
            calendarView.reloadData()
    
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableCellHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isKind(of: UITableView.self) {
            let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview!)
            if translation.y < 0 {
                // swipes from top to bottom of screen -> down
                NSLog("Table view scrolled Up")
                let element = deque.dequeueBack()
                let day = element?.keys.first!
                let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: day!)!
                let items = dataModel.getAgendaItems(day: nextDay)
                deque.enqueue([nextDay: items])
                deque.dequeueRemove()
                agendaView.reloadData()
            } else {
                NSLog("Table view scrolled Down")
                let element = deque.dequeue()
                let day = element?.keys.first!
                let prevDay = Calendar.current.date(byAdding: .day, value: -1, to: day!)!
                let items = dataModel.getAgendaItems(day: prevDay)
                deque.enqueueFront([prevDay: items])
                deque.dequeueBackRemove()
                agendaView.reloadData()
                
            }
        }

        
    }
    
    

}

