//
//  SearchShopTypeCell.swift
//  SearchFilter
//
//  Created by Patrick Marshall on 3/18/18.
//  Copyright © 2018 Patrick Marshall. All rights reserved.
//

import UIKit

class SearchShopTypeCell: UITableViewCell {

    // IB
    @IBOutlet weak var imgCheck: UIImageView!
    @IBOutlet weak var lblShopType: UILabel!
    @IBOutlet weak var imgBadge: UIImageView!
    
    // Data
    var state: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    // Setup View if selected will show selected icon
    func setup() {
        if state! {
            imgCheck.image = UIImage(named: "ic-check")
        } else {
            imgCheck.image = UIImage(named: "ic-circle")
        }
    }
    
}
