import Foundation
import CoreLocation

struct LocationSelection: Codable, Equatable, Hashable {
    enum Source: String, Codable { case manual, device }
    let name: String
    let lat: Double
    let lon: Double
    let source: Source

    var coordinate: CLLocationCoordinate2D { .init(latitude: lat, longitude: lon) }
}
