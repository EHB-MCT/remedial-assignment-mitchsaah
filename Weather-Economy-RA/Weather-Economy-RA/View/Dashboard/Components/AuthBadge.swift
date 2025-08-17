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
    }
}
