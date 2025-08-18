import SwiftUI
import FirebaseAuth

struct DashboardView: View {
    @EnvironmentObject private var appState: AppState
    @StateObject private var weatherVM = WeatherViewModel()
    @State private var showOnboarding = false
    
    private var loggedInIdentity: String {
        if let user = Auth.auth().currentUser {
            return user.email ?? user.uid
        }
        return "unknown"
    }
    
    var body: some View {
        VStack(spacing: 16) {
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
            
            if weatherVM.isLoading {
                LoadingCard()
            } else if let err = weatherVM.errorMessage {
                ErrorCard(message: err) { weatherVM.load() }
            }  else {
                InfographicSection(
                    uvi: weatherVM.uvi,
                    clouds: weatherVM.cloudiness,
                    condition: weatherVM.condition,
                    rain1h: weatherVM.rain1h,
                    estKWh: weatherVM.estimatedKWh,
                    estEUR: weatherVM.estimatedEUR,
                    onRefresh: { weatherVM.load() }
                )
            }
            
            Spacer()
            
            AuthBadge(identity: loggedInIdentity)
    
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
        }
        .padding()
        .onAppear {
            weatherVM.bootstrapFromPrefs {
                showOnboarding = (weatherVM.selectedLocation.name == LocationSelection.brussels.name)
                weatherVM.load()
            }
        }
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView(
                onCompleted: { location, solar in
                    UserPrefsService.saveLocation(location)
                    UserPrefsService.saveSolar(solar)
                    weatherVM.updateLocation(location)
                    weatherVM.applySolarPrefs(solar)
                    showOnboarding = false
                },
                onSkip: {
                    showOnboarding = false
                }
            )
        }
    }
}
