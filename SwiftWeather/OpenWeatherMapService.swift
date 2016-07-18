//
// Created by Jake Lin on 9/2/15.
// Copyright (c) 2015 Jake Lin. All rights reserved.
//

import Foundation
import CoreLocation

import SwiftyJSON

struct OpenWeatherMapService: WeatherServiceProtocol {
  private let urlPath = "http://api.openweathermap.org/data/2.5/forecast"

  private func getFirstFourForecasts(json: JSON) -> [Forecast] {
    var forecasts: [Forecast] = []

    for index in 0...3 {
      guard let forecastTempDegrees = json["list"][index]["main"]["temp"].double,
        rawDateTime = json["list"][index]["dt"].double,
        forecastCondition = json["list"][index]["weather"][0]["id"].int,
        forecastIcon = json["list"][index]["weather"][0]["icon"].string else {
          break
      }

      let country = json["city"]["country"].string
      let forecastTemperature = Temperature(country: country!,
        openWeatherMapDegrees: forecastTempDegrees)
      let forecastTimeString = ForecastDateTime(rawDateTime).shortTime
      let weatherIcon = WeatherIcon(condition: forecastCondition, iconString: forecastIcon)
      let forcastIconText = weatherIcon.iconText

      let forecast = Forecast(time: forecastTimeString,
                          iconText: forcastIconText,
                       temperature: forecastTemperature.degrees)

      forecasts.append(forecast)
    }

    return forecasts
  }

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
    let task = session.dataTaskWithRequest(request,
        completionHandler: { data, response, networkError in

      // Check network error
      guard networkError == nil else {
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
        country = json["city"]["country"].string,
        city = json["city"]["name"].string,
        weatherCondition = json["list"][0]["weather"][0]["id"].int,
        iconString = json["list"][0]["weather"][0]["icon"].string else {
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


      weatherBuilder.forecasts = self.getFirstFourForecasts(json)

      completionHandler(weatherBuilder.build(), nil)
    })

    task.resume()
  }

  private func generateRequestURL(location: CLLocation) -> NSURL? {
    guard let components = NSURLComponents(string:urlPath) else {
      return nil
    }

    // get appId from Info.plist
    let filePath = NSBundle.mainBundle().pathForResource("Info", ofType: "plist")!
    let parameters = NSDictionary(contentsOfFile:filePath)
    let appId = parameters!["OWMAccessToken"]!.description

    let latitude = String(location.coordinate.latitude)
    let longitude = String(location.coordinate.longitude)

    components.queryItems = [NSURLQueryItem(name:"lat", value:latitude),
                             NSURLQueryItem(name:"lon", value:longitude),
                             NSURLQueryItem(name:"appid", value:String(appId))]

    return components.URL
  }
}
