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
        let nib = UINib(nibName: nibName(), bundle: bundle)
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
        
        set {
            time.text = newValue
        }
    }
    
    @IBInspectable var iconText: String? {
        get {
            return icon.text
        }
        
        set {
            icon.text = newValue
        }
    }
    
    @IBInspectable var temperatureText: String? {
        get {
            return temperature.text
        }
        
        set {
            temperature.text = newValue
        }
    }
    
    @IBInspectable var timeColor: UIColor {
        get {
            return time.textColor
        }
        
        set {
            time.textColor = newValue
        }
    }
    
    @IBInspectable var iconColor: UIColor {
        get {
            return icon.textColor
        }
        
        set {
            icon.textColor = newValue
        }
    }
    
    @IBInspectable var temperatureColor: UIColor {
        get {
            return temperature.textColor
        }
        
        set {
            temperature.textColor = newValue
        }
    }
    
//    @IBInspectable var bgColor: UIColor {
//        get {
//            return view.backgroundColor!
//        }
//        
//        set {
//            view.backgroundColor = newValue
//        }
//    }
    
    // MARK: - Private
    private func nibName() -> String {
        return self.dynamicType.description().componentsSeparatedByString(".").last!
    }
}


