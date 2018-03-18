//
//  SearchFilterPriceCell.swift
//  SearchFilter
//
//  Created by Patrick Marshall on 3/18/18.
//  Copyright © 2018 Patrick Marshall. All rights reserved.
//

import UIKit
import SwiftRangeSlider

class SearchFilterPriceCell: UITableViewCell {

    // IB
    @IBOutlet weak var txtMinPrice: UITextField!
    @IBOutlet weak var txtMaxPrice: UITextField!
    @IBOutlet weak var rangeSlider: RangeSlider!
    
    // Delegate
    var delegate: SearchFilterDelegate?
    
    // Current Value
    var lowerValue: Double?
    var upperValue: Double?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setup() {
        setupRangeSlide()
        
        // Setup Text Field Value According to Range Slider Condition
        self.txtMinPrice.text = rangeSlider.lowerValue.toInt().toString().asRupiah()
        self.txtMaxPrice.text = rangeSlider.upperValue.toInt().toString().asRupiah()
    }
    
    // Setup Range Slider Components
    func setupRangeSlide() {
        rangeSlider.hideLabels = true
        
        rangeSlider.knobBorderThickness = 1.0
        rangeSlider.knobBorderTintColor = UIColor.baseGreen
        rangeSlider.knobTintColor = UIColor.white
        rangeSlider.knobSize = 2.0
        
        rangeSlider.stepValue = 20000.0
        
        rangeSlider.maximumValue = 500000.0
        rangeSlider.minimumValue = 10000.0
        rangeSlider.upperValue = upperValue!
        rangeSlider.lowerValue = lowerValue!
        rangeSlider.minimumDistance = 0.0
        
        rangeSlider.trackThickness = 0.2
        rangeSlider.trackTintColor = UIColor.lightGray
        rangeSlider.trackHighlightTintColor = UIColor.baseGreen
        
    }
    
    // Called every time Min Texfield edited
    @IBAction func txtMinEdited(_ sender: Any) {
        rangeSlider.lowerValue = self.txtMinPrice.text!.getValue().toDouble()
        self.txtMinPrice.text = self.txtMinPrice.text?.asRupiah()
        updateValue()
    }
    
    // Called every time Max Texfield edited
    @IBAction func txtMaxEdited(_ sender: Any) {
        rangeSlider.upperValue = self.txtMaxPrice.text!.getValue().toDouble()
        self.txtMaxPrice.text = self.txtMaxPrice.text?.asRupiah()
        updateValue()
    }
    
    // Called every time Slider moved
    @IBAction func rangeSliderValueChanged(_ sender: Any) {
        self.txtMinPrice.text = rangeSlider.lowerValue.toInt().toString().asRupiah()
        self.txtMaxPrice.text = rangeSlider.upperValue.toInt().toString().asRupiah()
        updateValue()
    }
    
    // Update value in Filter Page
    func updateValue() {
        self.delegate?.changePriceValue(pmin: rangeSlider.lowerValue.toInt(), pmax: rangeSlider.upperValue.toInt())
    }
    
}
