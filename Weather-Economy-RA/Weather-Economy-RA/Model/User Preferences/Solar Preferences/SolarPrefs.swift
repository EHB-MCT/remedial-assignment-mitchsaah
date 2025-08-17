import Foundation

struct SolarPrefs: Codable, Equatable {
    var capacityKwp: Double
    var efficiency: Double
    var tariffEurPerKwh: Double

    static let `default` = SolarPrefs(capacityKwp: 3.5, efficiency: 0.80, tariffEurPerKwh: 0.30)
}
