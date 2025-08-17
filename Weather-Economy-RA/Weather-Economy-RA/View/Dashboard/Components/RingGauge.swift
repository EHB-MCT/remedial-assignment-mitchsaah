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
                    
                    Circle()
                        .trim(from: 0, to: max(0, min(1, progress)))
                        .stroke(
                            AngularGradient(
                                gradient: Gradient(colors: [Color.green, Color.yellow, Color.orange, Color.red]),
                                center: .center
                            ),
                            style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                        .animation(.easeOut(duration: 0.6), value: progress)
                }
                .padding(18)
                
                VStack(spacing: 2) {
                    Text(valueText)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text(title)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 8)
            }
            .padding(8)
        }
    }
}
