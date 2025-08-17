import SwiftUI

struct InfographicSection: View {
    let uvi: Double?
    let clouds: Int?
    let condition: String?
    let rain1h: Double?
    let estKWh: Double?
    let estEUR: Double?
    let onRefresh: () -> Void
    
    @State private var rightColumnHeight: CGFloat = 0

    var body: some View {
        EmptyView()
    }
}
