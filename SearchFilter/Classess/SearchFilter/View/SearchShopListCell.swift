//
//  SearchShopListCell.swift
//  SearchFilter
//
//  Created by Patrick Marshall on 3/18/18.
//  Copyright © 2018 Patrick Marshall. All rights reserved.
//

import UIKit

class SearchShopListCell: UITableViewCell {

    // IB
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Shop Type Data
    var shops: [ShopTypeModel] = []
    
    // Delegate
    var delegate: SearchFilterDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setup() {
        // Setup Collection View
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // Register Cell
        self.collectionView.register(UINib(nibName: "SearchShopCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SearchShop")
        
        self.collectionView.reloadData()
    }
    
}

extension SearchShopListCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Remove tapped item and Update filter data
        self.shops.remove(at: indexPath.row)
        self.delegate?.changeShopType(shop: self.shops)
        self.collectionView.deleteItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemPerRow: CGFloat = 2.0
        let width = ((collectionView.layer.frame.width) / itemPerRow) - 4.0
        let height: CGFloat = 35.0
        return CGSize(width: width , height: height)
    }
}

extension SearchShopListCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchShop", for: indexPath) as! SearchShopCollectionCell
        cell.lblShopType.text = shops[indexPath.row].name
        cell.setup()
        return cell
    }
}
