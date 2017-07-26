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
    
    //Constants
    let calendarViewCellColor = UIColor.blue
    
    var dates = [Int]()
    var noOfDays = 7
    var highlightIndex = 0
    var dataModel = DataModel()
    // Hardcoded agenda items for the tableview datasource. Change this later
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for i in 0 ..< 31 {
            dates.append(i)
        }
        //mainScrollView.delegate = self
        calendarView.dataSource = self
        calendarView.delegate = self
        agendaView.dataSource = self
        agendaView.delegate = self
        
        navBar.topItem?.title = dataModel.getMonth(month: getDate().month!)
        let dayOfMonth = getDate().day!
        highlightIndex = dates.index(of: dayOfMonth)!
        //highlightIndex = 23
        print(highlightIndex)
        //populateAgendaItems(agendaItems : &agendaItems)
        
        
    }
    
    // This method populates some dummy data. Test later for integrations with calendars
    func populateAgendaItems(agendaItems: inout [[String]]) {
       
    }
    
    func getDate() -> DateComponents {
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        //let finalDate = String(describing: day) + ":" + String(describing: month) + ":" + String(describing: year)
        return components
        
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("In table views")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calendarView.dequeueReusableCell(withReuseIdentifier: "reuseCalendarCell", for: indexPath) as! CalendarCellCollectionViewCell
        
        if(indexPath.row == highlightIndex) {
            cell.day_label.backgroundColor = calendarViewCellColor
        }
        cell.day_label.text = String(dates[indexPath.row])
        return cell
        
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
        cell.dayMonthLabel.text = agenda.keys.first
        let details = dataModel.getAgendaItems()[i].values
        
        // Unneccesaary O(n^2) loop. Optimize
        for day in details {
            for indDetails in day {
                cell.agendaDetails.text?.append(indDetails)
            }
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfDays - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfDays))
        return CGSize(width: size, height: size)
    }
    


}

