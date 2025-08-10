import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        Text("Dashboard")
            .font(.largeTitle)
            .padding()
        
        Spacer()
                    
        Button(action: {
            appState.signOut()
        }) {
            Text("Log out")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .cornerRadius(8)
        }
        .padding(.horizontal)
    }
}
