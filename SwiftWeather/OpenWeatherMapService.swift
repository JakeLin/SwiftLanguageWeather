//
// Created by Jake Lin on 9/2/15.
// Copyright (c) 2015 Jake Lin. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

struct OpenWeatherMapService: WeatherServiceProtocol {
    fileprivate let urlPath = "http://api.openweathermap.org/data/2.5/forecast"
    
    fileprivate func getFirstFourForecasts(_ weather: WeatherResponse) -> [Forecast] {
        var forecasts: [Forecast] = []
        
        for index in 0...3 {
            guard let forecastTempDegrees = weather.list[index].main.temp,
                let rawDateTime = weather.list[index].dt,
                let forecastCondition = weather.list[index].weather[0].id,
                let forecastIcon = weather.list[index].weather[0].icon else {
                    break
            }
            let country = weather.city.country
            let forecastTemperature = Temperature(country: country!,
                                                  openWeatherMapDegrees: Double(forecastTempDegrees))
            let forecastTimeString = ForecastDateTime(date: Double(rawDateTime), timeZone: TimeZone.current).shortTime
            let weatherIcon = WeatherIcon(condition: forecastCondition, iconString: forecastIcon)
            let forcastIconText = weatherIcon.iconText
            
            let forecast = Forecast(time: forecastTimeString,
                                    iconText: forcastIconText,
                                    temperature: forecastTemperature.degrees)
            
            forecasts.append(forecast)
        }
        
        return forecasts
    }
    
    func retrieveWeatherInfo(_ location: CLLocation, completionHandler: @escaping WeatherCompletionHandler) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        guard let url = generateRequestURL(location) else {
            let error = SWError(errorCode: .urlError)
            completionHandler(nil, error)
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            // Check network error
            guard error == nil else {
                let error = SWError(errorCode: .networkRequestFailed)
                completionHandler(nil, error)
                return
            }
            
            // Check JSON serialization error
            guard let data = data else {
                let error = SWError(errorCode: .jsonSerializationFailed)
                completionHandler(nil, error)
                return
            }
            
          
            // Get temperature, location and icon and check parsing error

            do{
                let decoder = JSONDecoder()
                let weather = try decoder.decode(WeatherResponse.self, from: data)
                
                    print(weather)
                
                guard let tempDegrees = weather.list[0].main.temp,
                    let country = weather.city.country,
                    let city = weather.city.name,
                    let weatherCondition = weather.list[0].weather[0].id,
                    let iconString = weather.list[0].weather[0].icon else {
                        let error = SWError(errorCode: .jsonParsingFailed)
                        completionHandler(nil, error)
                        return
                }
                
                var weatherBuilder = WeatherBuilder()
                let temperature = Temperature(country: country, openWeatherMapDegrees:Double(tempDegrees))
                weatherBuilder.temperature = temperature.degrees
                weatherBuilder.location = city
                
                let weatherIcon = WeatherIcon(condition: weatherCondition, iconString: iconString)
                weatherBuilder.iconText = weatherIcon.iconText
                
                weatherBuilder.forecasts = self.getFirstFourForecasts(weather)
                
                completionHandler(weatherBuilder.build(), nil)
                
            }catch let err{
                let error = SWError(errorCode: .jsonParsingFailed)
                completionHandler(nil, error)
            }
            
           
            
           
        }
        
        task.resume()
    }
    
    fileprivate func generateRequestURL(_ location: CLLocation) -> URL? {
        guard var components = URLComponents(string:urlPath) else {
            return nil
        }
        
        // get appId from Info.plist
        let filePath = Bundle.main.path(forResource: "Info", ofType: "plist")!
        let parameters = NSDictionary(contentsOfFile:filePath)
//        let appId = parameters!["OWMAccessToken"]! as! String
        let appId = "857f750037379e2c5deff86f861e3211"

        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        
        components.queryItems = [URLQueryItem(name:"lat", value:latitude),
                                 URLQueryItem(name:"lon", value:longitude),
                                 URLQueryItem(name:"appid", value:appId)]
        
        return components.url
    }
}
