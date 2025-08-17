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
        GeometryReader { geo in
            let spacing: CGFloat = 12
            let columnWidth = (geo.size.width - spacing) / 2
            
            VStack(spacing: spacing) {
                HStack(alignment: .top, spacing: spacing) {
                    RingGauge(
                        progress: Metric.uvProgress(uvi ?? 0),
                        title: "UV Index",
                        valueText: Metric.oneDecimal(uvi) + " • " + Metric.uvLabel(for: uvi ?? 0),
                        lineWidth: 16
                    )
                    .frame(width: columnWidth,
                           height: max(190, rightColumnHeight))
                    .animation(.easeOut(duration: 0.25), value: rightColumnHeight)
                    
                    VStack(spacing: spacing) {
                        StatCard(
                            title: "Cloud Cover",
                            value: Metric.percent(clouds),
                            subtitle: "Less clouds → more output",
                            systemImage: "cloud.fill"
                        )
                        
                        let raining = (condition == "Rain") || ((rain1h ?? 0) > 0)
                        StatCard(
                            title: "Rain (last hour)",
                            value: (rain1h ?? 0).formatted(.number.precision(.fractionLength(1))) + " mm",
                            subtitle: raining ? "Rain detected" : "No rain",
                            systemImage: raining ? "cloud.rain.fill" : "drop.degreesign"
                        )
                    }
                    .frame(width: columnWidth)
                    .background(HeightReader())
                }
                .onPreferenceChange(HeightKey.self) { rightColumnHeight = $0 }
            }
        }
    }
}
