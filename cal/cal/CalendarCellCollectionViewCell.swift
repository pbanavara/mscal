//
//  CalendarCellCollectionViewCell.swift
//  cal
//
//  Created by pbanavara on 7/22/17.
//  Copyright © 2017 pbanavara. All rights reserved.
//

import UIKit

class CalendarCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var day_label: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contentView.backgroundColor = UIColor.clear
        day_label?.text = nil
    }
    
    func setBackgroundColor() {
        contentView.backgroundColor = UIColor.appleBlue()
    }
}
