//
//  SearchFilterDelegate.swift
//  SearchFilter
//
//  Created by Patrick Marshall on 3/18/18.
//  Copyright © 2018 Patrick Marshall. All rights reserved.
//

import Foundation

protocol SearchFilterDelegate {
    func changeSwitchValue(wholesale: Bool)
    func changePriceValue(pmin: Int, pmax: Int)
    func changeShopType(shop: [ShopTypeModel])
}
