import SwiftUI

enum Metric {
    static func uvLabel(for uvi: Double) -> String {
        switch uvi {
        case ..<3: return "Low"
        case 3..<6: return "Moderate"
        case 6..<8: return "High"
        case 8..<11: return "Very High"
        default: return "Extreme"
        }
    }
}
