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
        
        navBar.titleTextAttributes = ["June": "June"]
        let dayOfMonth = getDate()
        //highlightIndex = dates.index(of: dayOfMonth)!
        highlightIndex = 23
        print(highlightIndex)
    }
    
    func getDate() -> Int {
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        return day!
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
        let element = dates.remove(at: indexPath.row)
        print(dates)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = agendaView.dequeueReusableCell(withIdentifier: "agendaItem")!
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

