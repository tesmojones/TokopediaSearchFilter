//
//  SearchFilterVC.swift
//  SearchFilter
//
//  Created by Patrick Marshall on 3/17/18.
//  Copyright © 2018 Patrick Marshall. All rights reserved.
//

import UIKit

class SearchFilterVC: BaseViewController {

    // IB
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnApply: UIButton!
    
    // Delegate
    var delegate: SearchResultDelegate?
    
    // Filter Variable
    var pmin: Int = 10000
    var pmax: Int = 500000
    var wholesale: Bool = true
    var official: Bool = true
    var fshop: Int = 0
    
    // Shop Selected
    var shops: [ShopTypeModel] = []
    var fromDelegate: Bool = false
    var currentSelectedShop: [Bool] = [false, false]
    
    // Current Params
    var currentParams: SearchParam?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupCurrentParam()
        setupView()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.reloadData()
    }
    
    // Setup current loaded param to view
    func setupCurrentParam() {
        self.pmin = (currentParams?.pmin?.getValue())!
        self.pmax = (currentParams?.pmax?.getValue())!
        self.wholesale = (currentParams?.wholesale?.getBool())!
        if !fromDelegate {
            self.official = (currentParams?.official?.getBool())!
            self.fshop = (currentParams?.fshop?.getValue())!
        }
        self.shops.removeAll()
        if self.official {
            self.currentSelectedShop[0] = true
            let officialShop = ShopTypeModel(name: "Official Shop", image: "ic-official", isSelected: true)
            shops.append(officialShop)
        } else {
            self.currentSelectedShop[0] = false
        }
        
        if self.fshop == 2 {
            self.currentSelectedShop[1] = true
            let goldShop = ShopTypeModel(name: "Gold Merchant", image: "ic-gold", isSelected: true)
            shops.append(goldShop)
        } else {
            self.currentSelectedShop[1] = false
        }
    }
    
    func setupView() {
        // Setup Navigation Bar
        self.setTitle(title: "Filter")
        self.setNavBarColor(color: UIColor.white)
        self.showNavBar()
        self.setResetButton(caller: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // Set value to default value and reload tableview
    override func resetFilter() {
        self.pmin = 10000
        self.pmax = 500000
        self.wholesale = false
        self.shops.removeAll()
        self.currentSelectedShop = [false, false]
        self.official = false
        self.fshop = 0
        
        self.setupTableView()
    }
    
    // Apply filter to search result
    @IBAction func applyButtonPressed(_ sender: Any) {
        self.delegate?.applyFilter(pmin: self.pmin, pmax: self.pmax, wholesale: self.wholesale, official: self.official, fshop: self.fshop)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SearchFilterVC: SearchFilterDelegate {
    // Set current value according to wholesale switch
    func changeSwitchValue(wholesale: Bool) {
        self.wholesale = wholesale
    }
    
    // Set current value according to Range Slider
    func changePriceValue(pmin: Int, pmax: Int) {
        self.pmin = pmin
        self.pmax = pmax
    }
    
    // Change Shop Type List
    func changeShopType(shop: [ShopTypeModel]) {
        shops.removeAll()
        self.fromDelegate = true
        let fshop = shop.contains{ $0.name! == "Gold Merchant" && $0.isSelected! }
        let official = shop.contains{ $0.name! == "Official Shop" && $0.isSelected! }
        
        var fshops: Int = 0
        if fshop {
            fshops = 2
            let goldShop = ShopTypeModel(name: "Gold Merchant", image: "ic-gold", isSelected: true)
            shops.append(goldShop)
        } else {
            fshops = 0
        }
        if official {
            let officialShop = ShopTypeModel(name: "Official Shop", image: "ic-official", isSelected: true)
            shops.append(officialShop)
        }
        self.official = official
        self.fshop = fshops
        
        self.tableView.reloadData()
    }
}

extension SearchFilterVC: UITableViewDelegate {
    func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.estimatedSectionHeaderHeight = 8
        self.tableView.estimatedSectionHeaderHeight = 0
        
        self.tableView.register(UINib(nibName: "SearchFilterPriceCell", bundle: self.nibBundle), forCellReuseIdentifier: "FilterPrice")
        self.tableView.register(UINib(nibName: "SearchFilterTypeCell", bundle: self.nibBundle), forCellReuseIdentifier: "FilterType")
        self.tableView.register(UINib(nibName: "SearchFilterSwitchCell", bundle: self.nibBundle), forCellReuseIdentifier: "FilterSwitch")
        self.tableView.register(UINib(nibName: "SearchShopListCell", bundle: self.nibBundle), forCellReuseIdentifier: "ShopTypeList")
        
        self.tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 1:
                break
            default:
                // Go to Select Shop Type
                let storyboard = UIStoryboard(name: "Search", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "SearchShopType") as! SearchShopTypeVC
                self.setBackButton()
                vc.currentSelectedShop = self.currentSelectedShop
                vc.delegate = self
                self.navigationController?.pushViewController(vc, animated: true)
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
}

extension SearchFilterVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            if self.shops.count == 0 {
                return 1
            } else {
                return 2
            }
        default:
            return 2
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ShopTypeList") as! SearchShopListCell
                cell.shops = self.shops
                cell.delegate = self
                cell.setup()
                cell.selectionStyle = .none
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FilterType") as! SearchFilterTypeCell
                cell.lblType.text = "Shop Type"
                cell.selectionStyle = .none
                return cell
            }
            
        default:
            switch indexPath.row {
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FilterSwitch") as! SearchFilterSwitchCell
                cell.swcSwitch.isOn = self.wholesale
                cell.delegate = self
                cell.selectionStyle = .none
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FilterPrice") as! SearchFilterPriceCell
                cell.lowerValue = self.pmin.toDouble()
                cell.upperValue = self.pmax.toDouble()
                cell.delegate = self
                cell.selectionStyle = .none
                cell.setup()
                cell.rangeSlider.setNeedsLayout()
                return cell
            }
        }
    }
}
