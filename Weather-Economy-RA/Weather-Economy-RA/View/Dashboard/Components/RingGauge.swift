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
            
            VStack(spacing: 10) {
                ZStack {
                    Circle()
                        .stroke(Color.primary.opacity(0.1), lineWidth: lineWidth)
                }
                .padding(18)
            }
            .padding(8)
        }
    }
}
