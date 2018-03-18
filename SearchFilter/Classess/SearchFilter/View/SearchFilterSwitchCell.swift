//
//  SearchFilterSwitchCell.swift
//  SearchFilter
//
//  Created by Patrick Marshall on 3/18/18.
//  Copyright © 2018 Patrick Marshall. All rights reserved.
//

import UIKit

class SearchFilterSwitchCell: UITableViewCell {

    // IB
    @IBOutlet weak var lblSwitchName: UILabel!
    @IBOutlet weak var swcSwitch: UISwitch!
    
    // Delegate
    var delegate: SearchFilterDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func switchChanged(_ sender: Any) {
        self.delegate?.changeSwitchValue(wholesale: swcSwitch.isOn)
    }
    
}
