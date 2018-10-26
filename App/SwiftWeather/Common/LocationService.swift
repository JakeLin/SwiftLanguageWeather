//
//  LocationService.swift
//  SwiftWeather
//
//  Created by Jake Lin on 22/10/18.
//  Copyright © 2018 Jake Lin. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate {
    func locationDidUpdate(_ service: LocationService, location: CLLocation)
    func locationDidFail(withError error: SWError)
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

// MARK: - CLLocationManager Delegate
extension LocationService : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Current location: \(location)")
            delegate?.locationDidUpdate(self, location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let swError = SWError.unableToFindLocation
        delegate?.locationDidFail(withError: swError)
        print("Error finding location: \(error.localizedDescription)")
    }
}
