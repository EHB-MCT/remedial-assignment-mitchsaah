import SwiftUI

func iconFor(condition: String?) -> String {
    switch (condition ?? "").lowercased() {
    case "clear": return "sun.max.fill"
    case "clouds": return "cloud.fill"
    case "rain": return "cloud.rain.fill"
    case "snow": return "cloud.snow.fill"
    case "thunderstorm": return "cloud.bolt.rain.fill"
    case "drizzle": return "cloud.drizzle.fill"
    default: return "cloud.sun.fill"
    }
}
