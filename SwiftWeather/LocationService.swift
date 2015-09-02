//
//  LocationService.swift
//  SwiftWeather
//
//  Created by Jake Lin on 9/2/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService : NSObject, CLLocationManagerDelegate {
  private let locationManager = CLLocationManager()

  override init() {
    super.init()
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.requestLocation()
  }

  // MARK: - CLLocationManagerDelegate
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
        print("Current location: \(location)")
    } else {

    }
  }

  func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    print("Error finding location: \(error.localizedDescription)")
  }
}
