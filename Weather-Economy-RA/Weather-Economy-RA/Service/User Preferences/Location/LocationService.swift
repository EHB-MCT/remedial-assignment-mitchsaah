import CoreLocation

final class LocationService: NSObject, CLLocationManagerDelegate {
    static let shared = LocationService()

    private let manager = CLLocationManager()
    private var pending: ((Result<CLLocationCoordinate2D, Error>) -> Void)?
    
    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func requestOnce(_ completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        pending = completion
    }
}
