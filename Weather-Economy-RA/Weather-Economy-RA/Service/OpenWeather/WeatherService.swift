import Foundation
import Alamofire

final class WeatherService {
    static let shared = WeatherService()
    private let baseURL = "https://api.openweathermap.org/data/3.0/onecall"

    private var apiKey: String {
        guard let key = Bundle.main.infoDictionary?["OpenWeatherAPIKey"] as? String, !key.isEmpty else {
            fatalError("OpenWeatherAPIKey missing")
        }
        return key
    }
}
