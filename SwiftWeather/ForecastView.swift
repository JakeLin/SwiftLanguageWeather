//
//  Created by Jake Lin on 8/22/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable class ForecastView: UIView {
  // Our custom view from the XIB file
  var view: UIView!
  
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var iconLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  
  // MARK: - init
  override init(frame: CGRect) {
    super.init(frame: frame)
    view = loadViewFromNib()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    view = loadViewFromNib()
  }
  
  func loadViewFromNib() -> UIView {
    let bundle = NSBundle(forClass: self.dynamicType)
    let nib = UINib(nibName: nibName(), bundle: bundle)
    let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
    
    view.frame = bounds
    view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    addSubview(view);
    return view
  }

  // MARK: - ViewModel
  var viewModel: ForecastViewModel? {
    didSet {
      viewModel?.time.observe {
        [unowned self] in
        self.timeLabel.text = $0
      }

      viewModel?.iconText.observe {
        [unowned self] in
        self.iconLabel.text = $0
      }

      viewModel?.temperature.observe {
        [unowned self] in
        self.temperatureLabel.text = $0
      }
    }
  }

  func loadViewModel(viewModel: ForecastViewModel) {
    self.viewModel = viewModel
  }
  
  // MARK: - IBInspectable
  @IBInspectable var time: String? {
    get {
      return timeLabel.text
    }
    
    set {
      timeLabel.text = newValue
    }
  }
  
  @IBInspectable var icon: String? {
    get {
      return iconLabel.text
    }
    
    set {
      iconLabel.text = newValue
    }
  }
  
  @IBInspectable var temperature: String? {
    get {
      return temperatureLabel.text
    }
    
    set {
      temperatureLabel.text = newValue
    }
  }
  
  @IBInspectable var timeColor: UIColor {
    get {
      return timeLabel.textColor
    }
    
    set {
      timeLabel.textColor = newValue
    }
  }
  
  @IBInspectable var iconColor: UIColor {
    get {
      return iconLabel.textColor
    }
    
    set {
      iconLabel.textColor = newValue
    }
  }
  
  @IBInspectable var temperatureColor: UIColor {
    get {
      return temperatureLabel.textColor
    }
    
    set {
      temperatureLabel.textColor = newValue
    }
  }
  
  @IBInspectable var bgColor: UIColor {
    get {
      return view.backgroundColor!
    }
    
    set {
      view.backgroundColor = newValue
    }
  }
  
  // MARK: - Private
  private func nibName() -> String {
    return self.dynamicType.description().componentsSeparatedByString(".").last!
  }
}
