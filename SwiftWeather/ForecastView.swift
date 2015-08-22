//
//  ForecastView.swift
//  SwiftWeather
//
//  Created by Jake Lin on 8/22/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable class ForecastView: UIView {
    // Our custom view from the XIB file
    var view: UIView!
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var icon: UILabel!
    @IBOutlet weak var temperature: UILabel!
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "ForecastView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(view);
        return view
    }
    
    // MARK: - IBInspectable
    @IBInspectable var timeText: String? {
        get {
            return time.text
        }
        
        set(timeText) {
            time.text = timeText
        }
    }
    
    @IBInspectable var iconText: String? {
        get {
            return icon.text
        }
        
        set(iconText) {
            icon.text = iconText
        }
    }
    
    @IBInspectable var temperatureText: String? {
        get {
            return temperature.text
        }
        
        set(temperatureText) {
            temperature.text = temperatureText
        }
    }

}


