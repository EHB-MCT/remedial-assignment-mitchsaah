import SwiftUI

struct AuthBadge: View {
    let identity: String

    var body: some View {
        VStack(spacing: 6) {
            Text("Logged in as")
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack(spacing: 8) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.title3)
                    .symbolRenderingMode(.hierarchical)
                
                Text(identity)
                    .font(.subheadline).bold()
                    .multilineTextAlignment(.center)
                    .textSelection(.enabled)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .padding(.horizontal, 14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .strokeBorder(Color.primary.opacity(0.06), lineWidth: 1)
        )
    }
}
