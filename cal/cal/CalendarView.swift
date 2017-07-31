//
//  CalendarView.swift
//  cal
//
//  Created by pbanavara on 7/26/17.
//  Copyright © 2017 pbanavara. All rights reserved.
//

import UIKit

class CalendarView: UICollectionView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override var contentSize: CGSize {
        return CGSize(width: contentSize.width, height: contentSize.height * 2)
    }

}
