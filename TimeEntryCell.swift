//
//  TimeEntryCell.swift
//  TimeManager
//
//  Created by Alfredo Castillo on 8/19/15.
//  Copyright © 2015 Alfredo Castillo. All rights reserved.
//

import UIKit

class TimeEntryCell: UITableViewCell {
    
    
    @IBOutlet var totalTimeLabel: UILabel!
    @IBOutlet var startTimeLabel: UILabel!
    @IBOutlet var stopTimeLabel: UILabel!
    @IBOutlet var projectNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
