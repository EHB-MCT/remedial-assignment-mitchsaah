import CoreLocation

struct GeocodingService {
    static func search(_ query: String, completion: @escaping (Result<[LocationSelection], Error>) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(query) { placemarks, error in
            if let error = error { return completion(.failure(error)) }
        }
    }
}
