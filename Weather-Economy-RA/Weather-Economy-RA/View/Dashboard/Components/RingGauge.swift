import SwiftUI

struct RingGauge: View {
    let progress: Double
    let title: String
    let valueText: String
    var lineWidth: CGFloat = 14

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        }
    }
}
