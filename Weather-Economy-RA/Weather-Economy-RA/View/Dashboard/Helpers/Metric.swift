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
    
    static func uvProgress(_ uvi: Double) -> Double {
        let capped = min(max(uvi, 0), 11)
        return capped / 11.0
    }
}
