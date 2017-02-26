//
//  Created by Jake Lin on 9/2/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate {
  func locationDidUpdate(_ service: LocationService, location: CLLocation)
}

class LocationService: NSObject {
  var delegate: LocationServiceDelegate?

  fileprivate let locationManager = CLLocationManager()

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
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      print("Current location: \(location)")
      delegate?.locationDidUpdate(self, location: location)
    }
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error finding location: \(error.localizedDescription)")
  }
}
