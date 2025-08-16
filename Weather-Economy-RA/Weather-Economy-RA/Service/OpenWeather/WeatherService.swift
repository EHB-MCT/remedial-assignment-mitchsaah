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
    
    func fetchCurrent(lat: Double, lon: Double, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let params: [String: Any] = [
            "lat": lat,
            "lon": lon,
            "exclude": "minutely,hourly,daily,alerts",
            "units": "metric",
            "appid": apiKey
        ]
        
        AF.request(baseURL, parameters: params)
            .validate()
            .responseDecodable(of: WeatherResponse.self) { response in
                switch response.result {
                case .success(let data): completion(.success(data))
                case .failure(let error): completion(.failure(error))
                }
            }
    }
}
