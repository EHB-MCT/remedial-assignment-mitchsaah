import SwiftUI

struct LoadingCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
                .frame(height: 120)
            ProgressView("Fetching weather…")
        }
    }
}
