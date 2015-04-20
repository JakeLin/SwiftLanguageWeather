//
//  ViewController.swift
//  Swift Weather
//
//  Created by Jake Lin on 4/06/2014.
//  Copyright (c) 2014 rushjet. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import SwiftWeatherService


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager:CLLocationManager = CLLocationManager()
    
    @IBOutlet var loadingIndicator : UIActivityIndicatorView! = nil
    @IBOutlet var icon : UIImageView!
    @IBOutlet var temperature : UILabel!
    @IBOutlet var loading : UILabel!
    @IBOutlet var location : UILabel!
    @IBOutlet weak var time1: UILabel!
    @IBOutlet weak var time2: UILabel!
    @IBOutlet weak var time3: UILabel!
    @IBOutlet weak var time4: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var temp1: UILabel!
    @IBOutlet weak var temp2: UILabel!
    @IBOutlet weak var temp3: UILabel!
    @IBOutlet weak var temp4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.loadingIndicator.startAnimating()
        
        let background = UIImage(named: "background.png")
        self.view.backgroundColor = UIColor(patternImage: background!)
        
        let singleFingerTap = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        self.view.addGestureRecognizer(singleFingerTap)
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        locationManager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // It maybe a Xcode 6.2 beta Swift compiler's bug, it throws "command failed due to signal segmentation fault 11" error
    /*
    func updateWeatherInfo(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let service = SwiftWeatherService.WeatherService()
        service.retrieveForecast(latitude, longitude: longitude,
            success: { response in
                println(response)
                // self.updateUISuccess(response.object!)
            }, failure:{ response in
                println(response)
                println("Error: " + response.error!.localizedDescription)
                self.loading.text = "Internet appears down!"
            })
    }
    */
    
    func updateWeatherInfo(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let url = "http://api.openweathermap.org/data/2.5/forecast"
        let params = ["lat":latitude, "lon":longitude]
        println(params)
        
        Alamofire.request(.GET, url, parameters: params)
            .responseJSON { (request, response, json, error) in
                if(error != nil) {
                    println("Error: \(error)")
                    println(request)
                    println(response)
                    self.loading.text = "Internet appears down!"
                }
                else {
                    println("Success: \(url)")
                    println(request)
                    var json = JSON(json!)
                    self.updateUISuccess(json)
                }
        }
    }
    
    func updateUISuccess(json: JSON) {
        self.loading.text = nil
        self.loadingIndicator.hidden = true
        self.loadingIndicator.stopAnimating()
        
        let service = SwiftWeatherService.WeatherService()
        
        // If we can get the temperature from JSON correctly, we assume the rest of JSON is correct.
        if let tempResult = json["list"][0]["main"]["temp"].double {
            // Get country
            let country = json["city"]["country"].stringValue
            
            // Get and convert temperature
            var temperature = service.convertTemperature(country, temperature: tempResult)
            self.temperature.text = "\(temperature)°"
            
            // Get city name
            self.location.text = json["city"]["name"].stringValue
            
            // Get and set icon
            let weather = json["list"][0]["weather"][0]
            let condition = weather["id"].intValue
            var icon = weather["icon"].stringValue
            var nightTime = service.isNightTime(icon)
            service.updateWeatherIcon(condition, nightTime: nightTime, index: 0, callback: self.updatePictures)
            
            // Get forecast
            for index in 1...4 {
                println(json["list"][index])
                if let tempResult = json["list"][index]["main"]["temp"].double {
                    // Get and convert temperature
                    var temperature = service.convertTemperature(country, temperature: tempResult)
                    if (index==1) {
                        self.temp1.text = "\(temperature)°"
                    }
                    else if (index==2) {
                        self.temp2.text = "\(temperature)°"
                    }
                    else if (index==3) {
                        self.temp3.text = "\(temperature)°"
                    }
                    else if (index==4) {
                        self.temp4.text = "\(temperature)°"
                    }

                    // Get forecast time
                    var dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "HH:mm"
                    let rawDate = json["list"][index]["dt"].doubleValue
                    let date = NSDate(timeIntervalSince1970: rawDate)
                    let forecastTime = dateFormatter.stringFromDate(date)
                    if (index==1) {
                        self.time1.text = forecastTime
                    }
                    else if (index==2) {
                        self.time2.text = forecastTime
                    }
                    else if (index==3) {
                        self.time3.text = forecastTime
                    }
                    else if (index==4) {
                        self.time4.text = forecastTime
                    }
                    
                    // Get and set icon
                    let weather = json["list"][index]["weather"][0]
                    let condition = weather["id"].intValue
                    var icon = weather["icon"].stringValue
                    var nightTime = service.isNightTime(icon)
                    service.updateWeatherIcon(condition, nightTime: nightTime, index: index, callback: self.updatePictures)
                }
                else {
                    continue
                }
            }
        }
        else {
            self.loading.text = "Weather info is not available!"
        }
    }
    
    func updatePictures(index: Int, name: String) {
        if (index==0) {
            self.icon.image = UIImage(named: name)
        }
        if (index==1) {
            self.image1.image = UIImage(named: name)
        }
        if (index==2) {
            self.image2.image = UIImage(named: name)
        }
        if (index==3) {
            self.image3.image = UIImage(named: name)
        }
        if (index==4) {
            self.image4.image = UIImage(named: name)
        }
    }
    
    //MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var location:CLLocation = locations[locations.count-1] as! CLLocation
        if (location.horizontalAccuracy > 0) {
            self.locationManager.stopUpdatingLocation()
            println(location.coordinate)
            updateWeatherInfo(location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
        self.loading.text = "Can't get your location!"
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
