//
//  OpenWeatherMapService.swift
//  SwiftWeather
//
//  Created by Jake Lin on 23/10/18.
//  Copyright © 2018 Jake Lin. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

struct OpenWeatherMapService: WeatherServiceProtocol {
    private let urlPath = "https://api.openweathermap.org/data/2.5/forecast"
    
    func requestWeather(location: CLLocation, completionHandler: @escaping WeatherCompletionHandler) {
        guard let url = makeRequestURL(location: location) else {
            completionHandler(nil, .urlError)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error)  in
            // Check network error
            guard error == nil else {
                completionHandler(nil, .networkRequestFailed)
                return
            }
            
            // Check JSON serialization error
            guard let data = data, let json = try? JSON(data: data) else {
                completionHandler(nil, .jsonParsingFailed)
                return
            }
            
            // Get temperature, location and icon and check parsing error
            guard let degrees = json["list"][0]["main"]["temp"].double,
                let country = json["city"]["country"].string,
                let city = json["city"]["name"].string,
                let weatherCondition = json["list"][0]["weather"][0]["id"].int,
                let iconString = json["list"][0]["weather"][0]["icon"].string else {
                    completionHandler(nil, .jsonParsingFailed)
                    return
            }
            
            
            let temperature = TemperatureFormatter.format(country: country, openWeatherMapDegrees: degrees)
            let weatherIcon = WeatherIcon(condition: weatherCondition, iconString: iconString)
            let forecasts = self.getFirstFourForecasts(from: json)
            let weather = Weather(location: city, iconText: weatherIcon.iconText, temperature: temperature, forecasts: forecasts)
            
            completionHandler(weather, nil)
        }
        task.resume()
    }
}

private extension OpenWeatherMapService {
    func getFirstFourForecasts(from json: JSON) -> [Forecast] {
        var forecasts: [Forecast] = []
        
        for index in 0...3 {
            guard let forecastTempDegrees = json["list"][index]["main"]["temp"].double,
                let rawDateTime = json["list"][index]["dt"].double,
                let forecastCondition = json["list"][index]["weather"][0]["id"].int,
                let forecastIcon = json["list"][index]["weather"][0]["icon"].string else {
                    break
            }
            
            let country = json["city"]["country"].string ?? "US"
            let temperature = TemperatureFormatter.format(country: country,
                                                  openWeatherMapDegrees: forecastTempDegrees)
            let forecastTimeString = ForecastDateTime(date: rawDateTime, timeZone: TimeZone.current).shortTime
            let weatherIcon = WeatherIcon(condition: forecastCondition, iconString: forecastIcon)
            let forcastIconText = weatherIcon.iconText
            
            let forecast = Forecast(time: forecastTimeString,
                                    iconText: forcastIconText,
                                    temperature: temperature)
            
            forecasts.append(forecast)
        }
        
        return forecasts
    }
    
    func makeRequestURL(location: CLLocation) -> URL? {
        guard var components = URLComponents(string:urlPath) else {
            return nil
        }
        
        // get API key from Info.plist
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            return nil
        }
        
        let parameters = NSDictionary(contentsOfFile: filePath)
        
        // This is an Xcode 10 bug: Inconsistent ordering of Run Script phases and ProcessInfoPlistFile, we need to clean and rebuild to get `OWMAccessToken` from the plist. To walkaround it, we put the appId here.
        // More details can be found on http://www.openradar.me/44422906
//        guard let appId = parameters?["OWMAccessToken"] as? String else {
//            return nil
//        }
        let appId = parameters?["OWMAccessToken"] as? String ?? "b26c840fef70cdef165c7a67a3d998b6"
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        
        components.queryItems = [URLQueryItem(name:"lat", value:latitude),
                                 URLQueryItem(name:"lon", value:longitude),
                                 URLQueryItem(name:"appid", value:appId)]
        
        return components.url
    }
}
