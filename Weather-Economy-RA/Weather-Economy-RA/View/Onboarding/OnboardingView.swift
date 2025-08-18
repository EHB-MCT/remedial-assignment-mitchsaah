import SwiftUI

struct OnboardingView: View {
    var onCompleted: (LocationSelection, SolarPrefs) -> Void
    var onSkip: (() -> Void)?
    
    @State private var step: Int = 1
    @State private var selectedLocation: LocationSelection? = nil
    @State private var prefs: SolarPrefs = .default
    
    var body: some View {
        NavigationView {
            VStack {
                if step == 1 {
                    Text("Choose your location").font(.title2).bold().frame(maxWidth: .infinity, alignment: .leading)
                    LocationPickerView { sel in
                        selectedLocation = sel
                    }
                    .frame(maxHeight: 420)
                    
                    Button {
                        step = 2
                    } label: {
                        Text("Next")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(selectedLocation == nil)
                }
            }
                .padding()
                .navigationTitle("Setup")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
