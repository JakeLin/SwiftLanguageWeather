//
//  LocationService.swift
//  SwiftWeather
//
//  Created by Jake Lin on 9/2/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate {
  func locationDidUpdate(service: LocationService, location: CLLocation)
}

class LocationService : NSObject {
  var delegate: LocationServiceDelegate?
  
  private let locationManager = CLLocationManager()
  
  override init() {
    super.init()
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
  }
  
  func requestLocation() {
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestLocation()
  }
}

// MARK: - CLLocationManagerDelegate
extension LocationService : CLLocationManagerDelegate {
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      print("Current location: \(location)")
      delegate?.locationDidUpdate(self, location: location);
    }
  }
  
  func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    print("Error finding location: \(error.localizedDescription)")
  }
}