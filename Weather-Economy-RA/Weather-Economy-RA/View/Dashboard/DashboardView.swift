import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var appState: AppState
    @StateObject private var weatherVM = WeatherViewModel()

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Weather Economy")
                    .font(.title2).bold()
                Text("Brussels • Today")
                    .font(.subheadline).foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: iconFor(condition: weatherVM.condition))
                .symbolRenderingMode(.hierarchical)
                .font(.system(size: 28, weight: .semibold))
        }

        
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
