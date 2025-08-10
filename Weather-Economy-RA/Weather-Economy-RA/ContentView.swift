
import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        Group {
            if appState.user == nil {
                AuthView()
            } else {
                DashboardView()
            }
        }
        .animation(.easeInOut, value: appState.user != nil)
    }
}
