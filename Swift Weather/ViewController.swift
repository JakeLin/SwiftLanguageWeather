//
//  ViewController.swift
//  Swift Weather
//
//  Created by Jake Lin on 4/06/2014.
//  Copyright (c) 2014 rushjet. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager:CLLocationManager = CLLocationManager()
    
    @IBOutlet var icon : UIImageView
    @IBOutlet var temperature : UILabel
    @IBOutlet var loading : UILabel
    @IBOutlet var location : UILabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self;
        
        // The app might not work on iOS 8 Simulator (or device?)
        if ( ios8() ) {
            locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateWeatherInfo(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let manager = AFHTTPRequestOperationManager()
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&cnt=0"
        println(url)
        
        manager.GET(url,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                println("JSON: " + responseObject.description!)
                
                self.updateUISuccess(responseObject as NSDictionary!)
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)
                
                self.loading.text = "Internet appears down!"
            })
    }
    
    func updateUISuccess(jsonResult: NSDictionary!) {
        self.loading.text = nil
        
        var tempResult = jsonResult["main"]?["temp"] as Double
        var temperature: Double
        if (jsonResult["sys"]?["country"] as String == "US") {
            // Convert temperature to Fahrenheit if user is within the US
            temperature = round(((tempResult - 273.15) * 1.8) + 32)
        }
        else {
            // Otherwise, convert temperature to Celsius
            temperature = round(tempResult - 273.15)
        }
        // Is it a bug of Xcode 6? can not set the font size in IB.
        self.temperature.font = UIFont.boldSystemFontOfSize(60)
        self.temperature.text = "\(temperature)°"
        
        var name = jsonResult["name"]! as String
        self.location.font = UIFont.boldSystemFontOfSize(25)
        self.location.text = "\(name)"
        
        var condition = jsonResult["weather"]?[0]!["id"] as Int
        var sunrise = jsonResult["sys"]?["sunrise"] as Double
        var sunset = jsonResult["sys"]?["sunset"] as Double
        
        var nightTime = false
        var now = NSDate().timeIntervalSince1970
        // println(nowAsLong)
        
        if (now < sunrise || now > sunset) {
            nightTime = true
        }
        self.updateWeatherIcon(condition, nightTime: nightTime)
    }
    
    // Converts a Weather Condition into one of our icons.
    // Refer to: http://bugs.openweathermap.org/projects/api/wiki/Weather_Condition_Codes
    func updateWeatherIcon(condition: Int, nightTime: Bool) {
        // Thunderstorm
        if (condition < 300) {
            self.icon.image = UIImage(named: "Cloud-Lightning")
        }
        // Drizzle
        else if (condition < 500) {
            self.icon.image = UIImage(named: "Cloud-Drizzle")
        }
        // Rain / Freezing rain / Shower rain
        else if (condition < 600) {
            self.icon.image = UIImage(named: "Cloud-Rain")
        }
        // Snow
        else if (condition < 700) {
            self.icon.image = UIImage(named: "Cloud-Snow-Alt")
        }
        // Fog / Mist / Haze / etc.
        else if (condition < 771) {
            self.icon.image = UIImage(named: "Cloud-Fog")
        }
        // Tornado / Squalls
        else if (condition < 800) {
            self.icon.image = UIImage(named: "Cloud-Wind")
        }
        // Sky is clear
        else if (condition == 800) {
            if (nightTime){
                self.icon.image = UIImage(named: "Moon")
            }
            else {
                self.icon.image = UIImage(named: "Sun")
            }
        }
        // few / scattered / broken clouds
        else if (condition < 804) {
            if (nightTime){
                self.icon.image = UIImage(named: "Cloud-Moon")
            }
            else{
                self.icon.image = UIImage(named: "Cloud-Sun")
            }
        }
        // overcast clouds
        else if (condition == 804) {
            self.icon.image = UIImage(named: "Cloud")
        }
        // Extreme
        else if ((condition >= 900 && condition < 903) || (condition > 904 && condition < 1000)) {
            self.icon.image = UIImage(named: "Cloud-Wind")
        }
        // Cold
        else if (condition == 903) {
            self.icon.image = UIImage(named: "Thermometer-25")
        }
        // Hot
        else if (condition == 904) {
            self.icon.image = UIImage(named: "Thermometer-75")
        }
        else {
            // Weather condition not available
            self.icon.image = UIImage(named: "Cloud-Download")
        }
    }
    
    /*
    func finishLaunch() {
        //ask for authorization
        let status = CLLocationManager.authorizationStatus()
        if(status == CLAuthorizationStatus.NotDetermined) {
            self.locationManager.requestAlwaysAuthorization();
        }
        else {
            locationManager.startUpdatingLocation()
        }
    }
   
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.NotDetermined) {
            println("Auth status unkown still!");
        }
        locationManager.startUpdatingLocation()
    }
    */
    
    /*
    iOS 8 Utility
    */
    func ios8() -> Bool {
        println("iOS " + UIDevice.currentDevice().systemVersion)
        if ( UIDevice.currentDevice().systemVersion == "8.0" ) {
            return true
        } else {
            return false
        }
        
    }
    
    //CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: AnyObject[]!) {
        var location:CLLocation = locations[locations.count-1] as CLLocation
        
        if (location.horizontalAccuracy > 0) {
            self.locationManager.stopUpdatingLocation()
            println(location.coordinate)
            updateWeatherInfo(location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
}

