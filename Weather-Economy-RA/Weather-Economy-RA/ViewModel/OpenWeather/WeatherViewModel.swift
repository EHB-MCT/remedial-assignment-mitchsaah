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
