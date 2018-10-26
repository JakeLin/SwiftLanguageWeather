//
//  UIView+loadFromNib.swift
//  SwiftWeather
//
//  Created by Jake Lin on 25/10/18.
//  Copyright © 2018 Jake Lin. All rights reserved.
//

import UIKit

extension UIView {
    func loadFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return nil }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }
}
