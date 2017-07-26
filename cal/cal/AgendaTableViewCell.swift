//
//  AgendaTableViewCell.swift
//  cal
//
//  Created by pbanavara on 7/25/17.
//  Copyright © 2017 pbanavara. All rights reserved.
//

import UIKit

class AgendaTableViewCell: UITableViewCell {

    @IBOutlet weak var agendaDetails: UILabel!
    @IBOutlet weak var dayMonthLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
