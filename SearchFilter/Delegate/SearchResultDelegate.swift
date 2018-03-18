//
//  SearchResultDelegate.swift
//  SearchFilter
//
//  Created by Patrick Marshall on 3/18/18.
//  Copyright © 2018 Patrick Marshall. All rights reserved.
//

import Foundation

protocol SearchResultDelegate {
    func applyFilter(pmin: Int, pmax: Int, wholesale: Bool, official: Bool, fshop: Int)
}
