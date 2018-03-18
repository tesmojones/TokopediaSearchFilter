//
//  SearchResultVC.swift
//  SearchFilter
//
//  Created by Patrick Marshall on 3/17/18.
//  Copyright © 2018 Patrick Marshall. All rights reserved.
//

import UIKit

class SearchResultVC: BaseViewController {

    // Data Variable
    var query: String?
    var param: SearchParam?
    
    // Infinite Scroll
    let itemPerCall: Int = 10
    var currentItem: Int = 0
    var thereIsMore: Bool = true
    var requesting: Bool = false
    var firstTime: Bool = true
    
    // Filter Data
    var pmin: Int = 10000
    var pmax: Int = 500000
    var wholesale: Bool = false
    var official: Bool = false
    var fshop: Int = 0
    
    
    // API Integration
    var searchData: [DAOSearchResultData] = []
    
    // Collection View
    @IBOutlet weak var collectionView: UICollectionView!
    
    // IB
    @IBOutlet weak var filterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        clearData()
        setupCollectionView()
        getSearchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func setupView() {
        // Setup Navigation Bar
        self.setTitle(title: "Search")
        self.setNavBarColor(color: UIColor.white)
        self.showNavBar()
    }
    
    // Clear current search data array
    func clearData() {
        self.thereIsMore = true
        self.currentItem = 0
        self.searchData = []
        self.firstTime = true
    }
    
    func setupCollectionView() {
        // Setup Collection View
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // Register Cell
        self.collectionView.register(UINib(nibName: "SearchItemCell", bundle: self.nibBundle), forCellWithReuseIdentifier: "SearchItemCell")
    }
    
    // Calling API Get Search Data
    func getSearchData() {
        // Setting Up Param
        param = SearchParam(query: self.query, pmin: self.pmin.toString(), pmax: self.pmax.toString(), wholesale: self.wholesale, official: self.official, fshop: self.fshop.toString(), start: self.currentItem.toString(), row: self.itemPerCall.toString())
        
        // Only Call if there is no request and still has data
        if thereIsMore && !requesting {
            // Show Loading on First Time load
            if firstTime {
                firstTime = false
                self.showLoading(view: self.view)
            }
            
            // Set requesting to true to finish current request first
            self.requesting = true
            
            // Call The API
            Network.request(request: APISearch.getProductSearchList(param: param!), onSuccess: { response in
                let data = DAOSearchResultBaseClass(json: response)
                for dt in data.data! {
                    self.searchData.append(dt)
                }
                
                // Add Current Item according to item per call
                self.currentItem += self.itemPerCall
                
                // If data lower than item call per cell then there is no data anymore
                if (data.data?.count)! < self.itemPerCall {
                    self.thereIsMore = false
                }
                
                if data.data?.count == 0 {
                    self.showMessage(message: "Oops... Your Search Result is empty.", error: true)
                }
                
                self.stopLoading()
                self.requesting = false
                self.collectionView.reloadData()
            }, onFailure: { error in
                // If fail while calling API
                self.showMessage(message: error, error: true)
                self.stopLoading()
                self.requesting = false
            })
        }
    }
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        // Go to filter page
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchFilter") as! SearchFilterVC
        vc.delegate = self
        vc.currentParams = param
        self.setBackButton()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchResultVC: SearchResultDelegate {
    func applyFilter(pmin: Int, pmax: Int, wholesale: Bool, official: Bool, fshop: Int) {
        // Set filter data according to Filter Page
        self.pmin = pmin
        self.pmax = pmax
        self.wholesale = wholesale
        self.official = official
        self.fshop = fshop
    }
}

extension SearchResultVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.searchData.count - 1 {
            self.getSearchData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceSize: CGSize = UIScreen.main.bounds.size
        let itemPerRow: CGFloat = 2.0
        let width = ((deviceSize.width) / itemPerRow) - 1.0
        let height = deviceSize.height / CGFloat(2.5)
        return CGSize(width: width , height: height)
    }
}

extension SearchResultVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchItemCell", for: indexPath) as! SearchItemCell
        let data = self.searchData[indexPath.row]
        cell.setData(item: data)
        return cell
    }
}
