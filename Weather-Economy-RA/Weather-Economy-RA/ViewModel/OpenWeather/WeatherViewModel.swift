import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var uvi: Double?
    @Published var cloudiness: Int?
    @Published var condition: String?
    @Published var rain1h: Double?

    @Published var isLoading = false
    @Published var errorMessage: String?
}

extension WeatherViewModel {
    func load(lat: Double = 50.8503, lon: Double = 4.3517) {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        
        WeatherService.shared.fetchCurrent(lat: lat, lon: lon) { [weak self] result in
            Task { @MainActor in
                guard let self else { return }
                self.isLoading = false
                switch result {
                case .success(let data):
                    self.uvi = data.current.uvi
                    self.cloudiness = data.current.clouds
                    self.condition = data.current.weather.first?.main
                    self.rain1h = data.current.rain?.oneHour
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
