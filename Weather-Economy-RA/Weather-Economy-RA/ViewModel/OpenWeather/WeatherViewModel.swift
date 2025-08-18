import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var uvi: Double?
    @Published var cloudiness: Int?
    @Published var condition: String?
    @Published var rain1h: Double?

    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var estimatedKWh: Double?
    @Published var estimatedEUR: Double?
    
    @Published var selectedLocation: LocationSelection = .brussels
    @Published var placeName: String = LocationSelection.brussels.name
    @Published var solarPrefs: SolarPrefs = .default
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
                    self.recomputeEstimatesFromCurrent()
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func loadSelected() {
            load(lat: selectedLocation.lat, lon: selectedLocation.lon)
        }
    
    func refresh() { loadSelected() }
    
    func updateLocation(_ sel: LocationSelection) {
        selectedLocation = sel
        placeName = sel.name
        loadSelected()
    }
    
    func applySolarPrefs(_ prefs: SolarPrefs) {
        solarPrefs = prefs
        recomputeEstimatesFromCurrent()
    }
}

private extension WeatherViewModel {
    func recomputeEstimatesFromCurrent() {
        guard let uvi = uvi else {
            estimatedKWh = nil
            estimatedEUR = nil
            return
        }
        
        let uviFactor = max(0, min(uvi / 11.0, 1.0))
        let cloudFactor = 1.0 - Double(cloudiness ?? 0) / 100.0
        let irradianceFactor = max(0, uviFactor * cloudFactor)
        let kwh = solarPrefs.capacityKwp * solarPrefs.efficiency * irradianceFactor
        
        estimatedKWh = kwh
        estimatedEUR = kwh * solarPrefs.tariffEurPerKwh
    }
}
