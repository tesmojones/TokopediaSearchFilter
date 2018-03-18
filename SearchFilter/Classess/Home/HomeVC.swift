//
//  HomeVC.swift
//  SearchFilter
//
//  Created by Patrick Marshall on 3/16/18.
//  Copyright © 2018 Patrick Marshall. All rights reserved.
//

import UIKit

class HomeVC: BaseViewController {

    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblKeyword: UILabel!
    @IBOutlet weak var btnSearch: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Setup First View
        setup()
    }
    
    func setup() {
        // Hide Navigation Bar
        self.hideNavBar()
        
        // Setup Default View
        self.btnSearch.setTitle("Search", for: .normal)
        self.btnSearch.asRoundedBorderedButton(radius: nil, width: nil, color: "ffffff")
        self.vwBackground.backgroundColor = UIColor.baseGreen
        self.lblKeyword.text = "Keyword:"
        self.lblTitle.text = "Tokopedia Search Filter"
        self.txtSearch.text = "Samsung"
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
        // Go to Search Result
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchResult") as! SearchResultVC
        vc.query = self.txtSearch.text
        self.setBackButton()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
