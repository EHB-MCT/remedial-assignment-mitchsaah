import CoreLocation

final class LocationService: NSObject, CLLocationManagerDelegate {
    static let shared = LocationService()

    private let manager = CLLocationManager()
    private var pending: ((Result<CLLocationCoordinate2D, Error>) -> Void)?
}
