import Foundation

struct WeatherResponse: Decodable {
    let current: Current
}

struct Current: Decodable {
    let uvi: Double
    let clouds: Int
    let weather: [Condition]
    let rain: Rain?
}

struct Condition: Decodable {
    let main: String
}
