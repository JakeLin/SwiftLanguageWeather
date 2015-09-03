//
// Created by Jake Lin on 9/2/15.
// Copyright (c) 2015 Jake Lin. All rights reserved.
//

import Foundation
import CoreLocation

struct OpenWeatherMapService : WeatherServiceProtocol {
  private let urlPath = "http://api.openweathermap.org/data/2.5/weather"
  
  func retrieveWeatherInfo(location: CLLocation) -> Weather? {
    
    let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
    let session = NSURLSession(configuration: sessionConfig)
    
    if let url = generateRequestURL(location) {
      let request = NSURLRequest(URL: url)
      
      let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
        do {
          if let jsonData = data {
            let parsed = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments)
            print(parsed)
            
          }
        }
        catch let error as NSError {
          // Catch fires here, with an NSErrro being thrown from the JSONObjectWithData method
          print("A JSON parsing error occurred, here are the details:\n \(error)")
          
        }
      })
      
      task.resume()
    }
    
    return nil
  }
  
  private func generateRequestURL(location: CLLocation) -> NSURL? {
    if let components: NSURLComponents = NSURLComponents(string:urlPath) {
      components.queryItems = [NSURLQueryItem(name:"lat", value:String(location.coordinate.latitude)),
                               NSURLQueryItem(name:"lon", value:String(location.coordinate.longitude))]
      return components.URL
    }
    return nil
  }
}
