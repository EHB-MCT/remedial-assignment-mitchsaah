import CoreLocation

struct GeocodingService {
    static func search(_ query: String, completion: @escaping (Result<[LocationSelection], Error>) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(query) { placemarks, error in
            if let error = error { return completion(.failure(error)) }
            let results = (placemarks ?? []).compactMap { p -> LocationSelection? in
                guard let loc = p.location else { return nil }
                let name = [p.locality, p.administrativeArea, p.country]
                    .compactMap { $0 }
                    .joined(separator: ", ")
                return .init(
                    name: name.isEmpty ? query : name,
                    lat: loc.coordinate.latitude,
                    lon: loc.coordinate.longitude,
                    source: .manual
                )
            }
            completion(.success(results))
        }
    }
}
