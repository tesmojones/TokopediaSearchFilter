//
//  SearchItemCell.swift
//  SearchFilter
//
//  Created by Patrick Marshall on 3/17/18.
//  Copyright © 2018 Patrick Marshall. All rights reserved.
//

import UIKit
import SDWebImage

class SearchItemCell: UICollectionViewCell {
    
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    func setData(item: DAOSearchResultData) {
        // Setting web images
        if item.imageUri != nil {
            self.imgItem.setLoad(isLoad: true, style: .whiteLarge)
            self.imgItem.sd_setImage(with: URL(string: item.imageUri!), completed: { (image, error, cache, url) in
                self.imgItem.setLoad(isLoad: false, style: .whiteLarge)
                if error != nil {
                    self.imgItem.image = UIImage(named: "dummyPlaceholder")
                }
            })
        }else{
            self.imgItem.image = UIImage(named: "dummyPlaceholder")
        }
        self.lblTitle.text = item.name
        self.lblPrice.text = item.price
    }
}
