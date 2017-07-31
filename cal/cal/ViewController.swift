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
    let calendarViewCellColor = UIColor.blue
    
    var dates = [Int]()
    var noOfDays = 7
    var highlightIndex = 0
    var dataModel = DataModel()
    var bounds = CGRect()
    var tableBounds = CGRect()
    
    //calendar variables
    var currentMonth = 0
    var nextMonth = 0
    var previousMonth = 0
    
    var headerArray = ["M", "T", "W", "T", "F", "S", "S"]
       
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        //mainScrollView.delegate = self
        calendarView.dataSource = self
        calendarView.delegate = self
        agendaView.dataSource = self
        agendaView.delegate = self
        header.delegate = self
        header.dataSource = self
        
        navBar.topItem?.title = dataModel.getMonth(month: getDate().month!) + " " + String(getDate().year!)
        let dayOfMonth = getDate().day!
        
        //highlightIndex = 23
        print(highlightIndex)
        //populateAgendaItems(agendaItems : &agendaItems)
        bounds = calendarView.frame
        tableBounds = agendaView.frame
        for i in 0 ..< 70 {
            dates.append(i + dayOfMonth)
        }
        highlightIndex = dates.index(of: dayOfMonth)!
        
    }
    
    // This method populates some dummy data. Test later for integrations with calendars
    func populateAgendaItems(agendaItems: inout [[String]]) {
       
    }
    
    func getDate() -> DateComponents {
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let interval = calendar.dateInterval(of: .month, for: date)
        let days = calendar.dateComponents([.day], from: (interval?.start)!, to: (interval?.end)!).day!
        print(days)
        
        //let finalDate = String(describing: day) + ":" + String(describing: month) + ":" + String(describing: year)
        currentMonth = components.month!
        let nextMonthDate = Calendar.current.date(byAdding: .month, value: 1, to: date)
        nextMonth = calendar.dateComponents([.month], from: nextMonthDate!).month!
        let prevMonthDate = Calendar.current.date(byAdding: .month, value: -1, to: date)
        previousMonth = calendar.dateComponents([.month], from: prevMonthDate!).month!
        return components
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("In table views")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.getAgendaItems().count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.header) {
            return headerArray.count
        } else {
             return dates.count
        }
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.calendarView) {
            let cell = calendarView.dequeueReusableCell(withReuseIdentifier: "reuseCalendarCell", for: indexPath) as! CalendarCellCollectionViewCell
            let date = dates[indexPath.row]
            if(indexPath.row == highlightIndex) {
                cell.day_label.backgroundColor = calendarViewCellColor
                //TODO - Establish a network call to get the agenda for the day
                dataModel.setAgendaItems(items: [["Sunday" : ["new", "new1", "new2"]]])
                agendaView.reloadData()

            }
            cell.day_label.text = String(date)
            return cell
        } else {
            let cell = header.dequeueReusableCell(withReuseIdentifier: "reuseHeaderCell", for: indexPath) as! HeaderCollectionViewCell
            cell.cellLabel.text = headerArray[indexPath.row]
            return cell
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = calendarView.cellForItem(at: indexPath) as! CalendarCellCollectionViewCell
        cell.day_label.backgroundColor = calendarViewCellColor
        //let newDates = dates.map { IndexPath(row: $0, section: 0) }
        //calendarView.reloadItems(at: newDates)
    }
    
    
    
    /**
     Updates the table view when a collectionview cell/date is selected
    */
    func updateTableView() {
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = agendaView.dequeueReusableCell(withIdentifier: "agendaItem") as! AgendaTableViewCell
        let i = indexPath.row
        let agenda = dataModel.getAgendaItems()[i]
        cell.dayMonthLabel.text = agenda.keys.first!
        let details = dataModel.getAgendaItems()[i].values
        
        // Unneccesaary O(n^2) loop. Optimize
        for day in details {
            for indDetails in day {
                //var newLabel = cel
                
                cell.agendaDetails.text?.append(indDetails)
            }
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfDays))
        print(collectionView.bounds.width)
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfDays))
        return CGSize(width: size, height: size)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.isKind(of: UICollectionView.self) {
            //Resize the collectionview height
            let newCalendarSize = CGSize(width: calendarView.collectionViewLayout.collectionViewContentSize.width, height: bounds.size.height * 2.5)
            calendarView.frame = CGRect(origin: bounds.origin, size: newCalendarSize)
            // Resize the tableview height according to the new collectionview height
            // Change the hardcoded 120
            agendaView.frame = CGRect(x: tableBounds.origin.x, y: tableBounds.origin.y + 120,
                                      width: agendaView.contentSize.width, height: tableBounds.height)
    
        }
        if scrollView.isKind(of: UITableView.self) {
            
        }
    
    }

}

