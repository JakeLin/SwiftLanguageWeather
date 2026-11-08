import Foundation
import CoreLocation

struct WeatherSnapshot {
    let city: String
    let temperature: String
    let iconText: String
    let forecasts: [ForecastCard]
}

struct ForecastCard: Identifiable {
    let id = UUID()
    let time: String
    let iconText: String
    let temperature: String
}

private struct OpenWeatherResponse: Decodable {
    let city: City
    let list: [ForecastEntry]

    struct City: Decodable {
        let name: String
        let country: String
    }

    struct ForecastEntry: Decodable {
        let dt: TimeInterval
        let main: Main
        let weather: [WeatherCondition]

        struct Main: Decodable {
            let temp: Double
        }

        struct WeatherCondition: Decodable {
            let id: Int
            let icon: String
        }
    }
}

final class ModernWeatherService {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchWeather(for coordinate: CLLocationCoordinate2D) async throws -> WeatherSnapshot {
        let url = try makeURL(for: coordinate)
        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw WeatherRequestError.invalidResponse
        }

        let payload = try JSONDecoder().decode(OpenWeatherResponse.self, from: data)
        guard let current = payload.list.first else {
            throw WeatherRequestError.missingForecastData
        }

        let currentWeather = current.weather.first ?? OpenWeatherResponse.ForecastEntry.WeatherCondition(id: 800, icon: "01d")
        let cards = payload.list.prefix(4).map { item in
            let weather = item.weather.first ?? OpenWeatherResponse.ForecastEntry.WeatherCondition(id: 800, icon: "01d")
            let iconText = iconName(for: weather.id)
            let timeText = formatTime(item.dt)
            let temperatureText = formatTemperature(item.main.temp)
            return ForecastCard(time: timeText, iconText: iconText, temperature: temperatureText)
        }

        return WeatherSnapshot(
            city: payload.city.name,
            temperature: formatTemperature(current.main.temp),
            iconText: iconName(for: currentWeather.id),
            forecasts: cards
        )
    }

    private func formatTemperature(_ value: Double) -> String {
        let tempInCelsius = value - 273.15
        return String(format: "%.0f°", tempInCelsius)
    }

    private func formatTime(_ unixTimestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: unixTimestamp)
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    private func iconName(for weatherID: Int) -> String {
        switch weatherID {
        case 200...232: return "cloud.bolt.fill"
        case 300...321, 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "cloud.fog.fill"
        case 800: return "sun.max.fill"
        case 801...804: return "cloud.sun.fill"
        default: return "cloud.fill"
        }
    }

    private func makeURL(for coordinate: CLLocationCoordinate2D) throws -> URL {
        let apiKey = try appToken()
        var components = URLComponents(string: "https://api.openweathermap.org/data/2.5/forecast")!
        components.queryItems = [
            URLQueryItem(name: "lat", value: String(coordinate.latitude)),
            URLQueryItem(name: "lon", value: String(coordinate.longitude)),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric")
        ]

        guard let url = components.url else {
            throw WeatherRequestError.invalidURL
        }

        return url
    }

    private func appToken() throws -> String {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let info = NSDictionary(contentsOfFile: filePath),
              let token = info["OWMAccessToken"] as? String,
              !token.isEmpty else {
            throw WeatherRequestError.missingAPIKey
        }
        return token
    }
}

enum WeatherRequestError: LocalizedError {
    case invalidURL
    case invalidResponse
    case missingForecastData
    case missingAPIKey

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The weather request could not be built."
        case .invalidResponse:
            return "The weather service responded unexpectedly."
        case .missingForecastData:
            return "No forecast data was available for this location."
        case .missingAPIKey:
            return "Add your OpenWeatherMap API token to Info.plist under OWMAccessToken."
        }
    }
}
