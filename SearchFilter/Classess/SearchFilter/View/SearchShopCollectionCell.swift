//
//  SearchShopCollectionCell.swift
//  SearchFilter
//
//  Created by Patrick Marshall on 3/18/18.
//  Copyright © 2018 Patrick Marshall. All rights reserved.
//

import UIKit

class SearchShopCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var vwClose: UIView!
    @IBOutlet weak var lblShopType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup() {
        self.vwBackground.layer.borderWidth = 1.0
        self.vwBackground.layer.borderColor = UIColor.lightGray.cgColor
        self.vwBackground.layer.cornerRadius = (self.vwBackground.layer.frame.width / 12)
        
        self.vwClose.layer.borderWidth = 1.0
        self.vwClose.layer.borderColor = UIColor.lightGray.cgColor
        self.vwClose.layer.cornerRadius = (self.vwClose.layer.frame.width / 2)
    }
}
