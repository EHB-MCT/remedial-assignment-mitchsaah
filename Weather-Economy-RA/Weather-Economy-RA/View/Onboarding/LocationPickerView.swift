import SwiftUI

struct LocationPickerView: View {
    var onSelect: (LocationSelection) -> Void

    var body: some View {
        Text("Pick a location")
            .font(.headline)
            .padding()
    }
}
