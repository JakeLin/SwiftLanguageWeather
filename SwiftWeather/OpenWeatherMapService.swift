//
// Created by Jake Lin on 9/2/15.
// Copyright (c) 2015 Jake Lin. All rights reserved.
//

import Foundation
import CoreLocation

import SwiftyJSON

struct OpenWeatherMapService : WeatherServiceProtocol {
  private let urlPath = "http://api.openweathermap.org/data/2.5/forecast"
  
  func retrieveWeatherInfo(location: CLLocation, completionHandler: WeatherCompletionHandler) {
    let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
    let session = NSURLSession(configuration: sessionConfig)
    
    guard let url = generateRequestURL(location) else {
      let error = Error(errorCode: .URLError)
      completionHandler(nil, error)
      return
    }
    
    print(url)
    let request = NSURLRequest(URL: url)
    let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, networkError) -> Void in
      
      // Check network error
      if networkError != nil {
        let error = Error(errorCode: .NetworkRequestFailed)
        completionHandler(nil, error)
        return
      }
      
      // Check JSON serialization error
      guard let unwrappedData = data else {
        let error = Error(errorCode: .JSONSerializationFailed)
        completionHandler(nil, error)
        return
      }
      
      let json = JSON(data: unwrappedData)
      
      // Get temperature, location and icon and check parsing error
      guard let tempDegrees = json["list"][0]["main"]["temp"].double,
        country: String = json["city"]["country"].stringValue,
        city: String = json["city"]["name"].stringValue,
        weatherCondition: Int = json["list"][0]["weather"][0]["id"].intValue,
        iconString: String = json["list"][0]["weather"][0]["icon"].stringValue else {
          let error = Error(errorCode: .JSONParsingFailed)
          completionHandler(nil, error)
          return
      }
      
      var weatherBuilder = WeatherBuilder()
      let temperature = Temperature(country: country, openWeatherMapDegrees:tempDegrees)
      weatherBuilder.temperature = temperature.degrees
      weatherBuilder.location = city
      
      let weatherIcon = WeatherIcon(condition: weatherCondition, iconString: iconString)
      weatherBuilder.iconText = weatherIcon.iconText
      
      weatherBuilder.forecasts = []
      completionHandler(weatherBuilder.build(), nil)

      
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
  
  private func generateRequestURL(location: CLLocation) -> NSURL? {
    guard let components: NSURLComponents = NSURLComponents(string:urlPath) else {
      return nil
    }
    
    components.queryItems = [NSURLQueryItem(name:"lat", value:String(location.coordinate.latitude)),
                             NSURLQueryItem(name:"lon", value:String(location.coordinate.longitude))]
    return components.URL
  }
}
