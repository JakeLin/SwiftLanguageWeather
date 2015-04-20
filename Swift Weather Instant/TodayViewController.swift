//
//  TodayViewController.swift
//  Swift Weather Instant
//
//  Created by Marc Tarnutzer on 12.12.14.
//  Copyright (c) 2014 rushjet. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreLocation
import Alamofire
import SwiftyJSON
import SwiftWeatherService
class TodayViewController: UIViewController, NCWidgetProviding, CLLocationManagerDelegate {
    
    let locationManager:CLLocationManager = CLLocationManager()
    
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
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
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
        let service = SwiftWeatherService.WeatherService()
        
        // If we can get the temperature from JSON correctly, we assume the rest of JSON is correct.
        if let tempResult = json["list"][0]["main"]["temp"].double {
            // Get country
            let country = json["city"]["country"].stringValue

            // Get forecast
            for index in 0...3 {
                println(json["list"][index])
                if let tempResult = json["list"][index]["main"]["temp"].double {
                    // Get and convert temperature
                    var temperature = service.convertTemperature(country, temperature: tempResult)
                    if (index==0) {
                        self.temp1.text = "\(temperature)°"
                    }
                    else if (index==1) {
                        self.temp2.text = "\(temperature)°"
                    }
                    else if (index==2) {
                        self.temp3.text = "\(temperature)°"
                    }
                    else if (index==3) {
                        self.temp4.text = "\(temperature)°"
                    }
                    
                    // Get forecast time
                    var dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "HH:mm"
                    let rawDate = json["list"][index]["dt"].doubleValue
                    let date = NSDate(timeIntervalSince1970: rawDate)
                    let forecastTime = dateFormatter.stringFromDate(date)
                    if (index==0) {
                        self.time1.text = forecastTime
                    }
                    else if (index==1) {
                        self.time2.text = forecastTime
                    }
                    else if (index==2) {
                        self.time3.text = forecastTime
                    }
                    else if (index==3) {
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
            println("Weather info is not available!")
        }
    }
    
    func updatePictures(index: Int, name: String) {
        
        if (index==0) {
            self.image1.image = UIImage(named: name)
        }
        if (index==1) {
            self.image2.image = UIImage(named: name)
        }
        if (index==2) {
            self.image3.image = UIImage(named: name)
        }
        if (index==3) {
            self.image4.image = UIImage(named: name)
        }
    }

    //CLLocationManagerDelegate
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
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        locationManager.startUpdatingLocation()
        completionHandler(NCUpdateResult.NewData)
    }
    
}
