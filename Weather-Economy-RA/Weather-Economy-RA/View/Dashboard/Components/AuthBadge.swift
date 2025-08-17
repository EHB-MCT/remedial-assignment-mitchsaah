import SwiftUI

struct AuthBadge: View {

    var body: some View {
        VStack(spacing: 6) {
            Text("Logged in as")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
