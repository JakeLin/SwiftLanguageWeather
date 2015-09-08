//
// Created by Jake Lin on 9/2/15.
// Copyright (c) 2015 Jake Lin. All rights reserved.
//

import Foundation
import CoreLocation

import SwiftyJSON

struct OpenWeatherMapService : WeatherServiceProtocol {
  private let urlPath = "http://api.openweathermap.org/data/2.5/forecast"
  
  func retrieveWeatherInfo(location: CLLocation) -> Weather? {
    
    let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
    let session = NSURLSession(configuration: sessionConfig)
    
    if let url = generateRequestURL(location) {
      print(url)
    
      let request = NSURLRequest(URL: url)
      let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
        let json = JSON(data: data!)
        
        // Get temperature, location and icon
        guard let tempResult = json["list"][0]["main"]["temp"].double,
               country: String = json["city"]["country"].stringValue,
               city: String = json["city"]["name"].stringValue,
               weatherCondition: Int = json["list"][0]["weather"][0]["id"].intValue,
               weahterIcon: String = json["list"][0]["weather"][0]["icon"].stringValue else {
          return
        }
        print(tempResult)
        print(country)
        print(city)
        print(weatherCondition)
        print(weahterIcon)
          
        // Get the first four forecasts
        for index in 0...3 {
          guard let forecastTempReslut = json["list"][index]["main"]["temp"].double,
                   rawDateTime: Double =  json["list"][index]["dt"].doubleValue,
                   forecastCondition: Int = json["list"][index]["weather"][0]["id"].intValue,
                   forecastIcon: String = json["list"][index]["weather"][0]["icon"].stringValue else {
            break
          }
          
          print(forecastTempReslut)
          print(rawDateTime)
          print(forecastCondition)
          print(forecastIcon)
        }
      })
      
      task.resume()
    }
    
    return nil
  }
  
  private func generateRequestURL(location: CLLocation) -> NSURL? {
    guard let components: NSURLComponents = NSURLComponents(string:urlPath) else {
      return nil
    }
    
    components.queryItems = [NSURLQueryItem(name:"lat", value:String(location.coordinate.latitude)),
                             NSURLQueryItem(name:"lon", value:String(location.coordinate.longitude))]
    return components.URL
  }
}
