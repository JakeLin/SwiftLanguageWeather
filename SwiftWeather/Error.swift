//
//  Error.swift
//  SwiftWeather
//
//  Created by Jake Lin on 9/8/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation

struct Error {
  enum Code: Int {
    case NotAnError               = 0
    case NetworkRequestFailed     = -6000
    case JSONSerializationFailed  = -6001
  }
  
  let hasError: Bool
  let errorCode: Code
}