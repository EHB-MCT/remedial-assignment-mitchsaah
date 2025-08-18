import SwiftUI

struct OnboardingView: View {
    var onCompleted: (LocationSelection, SolarPrefs) -> Void
    var onSkip: (() -> Void)?
    
    var body: some View {
        NavigationView {
            VStack { }
                .padding()
                .navigationTitle("Setup")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
