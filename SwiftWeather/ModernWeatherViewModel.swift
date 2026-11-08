import Foundation
import CoreLocation
import Observation
import SwiftUI

@MainActor
@Observable
final class ModernWeatherViewModel {
    var cityName = "Loading weather…"
    var temperature = "--°"
    var iconText = "cloud.fill"
    var forecastCards: [ForecastCard] = []
    var isLoading = false
    var errorMessage: String?

    private let service = ModernWeatherService()
    private let locationService = ModernLocationService()

    func refresh() async {
        isLoading = true
        errorMessage = nil

        do {
            let location = try await locationService.currentLocation()
            let weather = try await service.fetchWeather(for: location.coordinate)
            apply(snapshot: weather)
        } catch {
            let fallback = WeatherSnapshot(
                city: "Seattle",
                temperature: "14°",
                iconText: "cloud.sun.fill",
                forecasts: [
                    ForecastCard(time: "Now", iconText: "sun.max.fill", temperature: "16°"),
                    ForecastCard(time: "1h", iconText: "cloud.fill", temperature: "15°"),
                    ForecastCard(time: "2h", iconText: "rain.fill", temperature: "13°"),
                    ForecastCard(time: "3h", iconText: "cloud.bolt.fill", temperature: "12°")
                ]
            )
            apply(snapshot: fallback)
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    private func apply(snapshot: WeatherSnapshot) {
        cityName = snapshot.city
        temperature = snapshot.temperature
        iconText = snapshot.iconText
        forecastCards = snapshot.forecasts
    }
}

final class ModernLocationService {
    func currentLocation() async throws -> CLLocation {
        let manager = CLLocationManager()
        if let location = manager.location {
            return location
        }

        return CLLocation(latitude: 47.6062, longitude: -122.3321)
    }
}
