import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        Text("Dashboard")
            .font(.largeTitle)
            .padding()
    }
}
