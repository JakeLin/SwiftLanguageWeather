//
//  WeatherIcon.swift
//  SwiftWeather
//
//  Created by Jake Lin on 9/9/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation

struct WeatherIcon {
  let iconText: String
  
  enum IconType : String {
    case day800 = "800d"
    case day201 = "201d"
    case night800 = "800n"
    case night201 = "201n"
  }
  
  init(condition: Int, iconString: String) {
    var rawValue: String
    
    // if iconString has 'n', it means night time.
    if iconString.rangeOfString("n") != nil {
      rawValue = String(condition) + "n"
    }
    else {
      // day time
      rawValue = String(condition) + "d"
    }
    
    guard let iconType = IconType(rawValue: rawValue) else {
      iconText = ""
      return
    }
    
    switch iconType {
    case .day800:
      iconText = "\u{f00d}"
    case .night800:
      iconText = "\u{f02e}"
    default:
      iconText = ""
    }
  }
}