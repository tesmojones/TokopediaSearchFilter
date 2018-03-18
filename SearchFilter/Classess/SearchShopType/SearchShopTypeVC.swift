//
//  SearchShopKindVC.swift
//  SearchFilter
//
//  Created by Patrick Marshall on 3/18/18.
//  Copyright © 2018 Patrick Marshall. All rights reserved.
//

import UIKit

class SearchShopTypeVC: BaseViewController {

    // IB
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnApply: UIButton!
    
    // Delegate
    var delegate: SearchFilterDelegate?
    
    // Shop Model
    var shops: [ShopTypeModel] = []
    
    // Current Selected Shop
    var currentSelectedShop: [Bool] = [false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        setupShopData()
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setupView() {
        // Setup Navigation Bar
        self.setTitle(title: "Shop Type")
        self.setNavBarColor(color: UIColor.white)
        self.showNavBar()
        self.setResetButton(caller: self)
    }
    
    override func resetFilter() {
        // Reset selected shop to none
        self.currentSelectedShop = [false, false]
        setupShopData()
        self.tableView.reloadData()
    }
    
    func setupShopData() {
        // Setting Data for tableview base on current selected data
        shops.removeAll()
        let officialShop = ShopTypeModel(name: "Official Shop", image: "ic-official", isSelected: self.currentSelectedShop[0])
        let goldShop = ShopTypeModel(name: "Gold Merchant", image: "ic-gold", isSelected: self.currentSelectedShop[1])
        
        shops.append(officialShop)
        shops.append(goldShop)
    }
    
    @IBAction func applyButtonPressed(_ sender: Any) {
        // Apply button
        self.delegate?.changeShopType(shop: self.shops)
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchShopTypeVC: UITableViewDelegate {
    func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.estimatedRowHeight = 100
        
        self.tableView.register(UINib(nibName: "SearchShopTypeCell", bundle: self.nibBundle), forCellReuseIdentifier: "ShopType")
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if shops[indexPath.row].isSelected! {
            shops[indexPath.row].isSelected = false
        } else {
            shops[indexPath.row].isSelected = true
        }
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension SearchShopTypeVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopType") as! SearchShopTypeCell
        let data = shops[indexPath.row]
        cell.state = data.isSelected
        cell.lblShopType.text = data.name
        cell.imgBadge.image = UIImage(named: data.image!)
        cell.setup()
        return cell
    }
}
