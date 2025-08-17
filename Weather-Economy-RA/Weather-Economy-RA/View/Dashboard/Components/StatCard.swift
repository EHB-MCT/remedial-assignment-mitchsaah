import SwiftUI

struct StatCard: View {
    let title: String
    let value: String
    let subtitle: String?
    let systemImage: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: systemImage)
                .font(.title3)
                .padding(10)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.headline)
                
                if let subtitle {
                    Text(subtitle)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
