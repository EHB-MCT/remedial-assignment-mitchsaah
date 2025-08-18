import SwiftUI

struct LocationPickerView: View {
    var onSelect: (LocationSelection) -> Void
    
    @State private var query = ""
    @State private var results: [LocationSelection] = []
    @State private var isSearching = false
    @State private var error: String?

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                TextField("Search city or address", text: $query)
                    .textFieldStyle(.roundedBorder)
                
                Button("Search") {}
                    .buttonStyle(.borderedProminent)
            }
            
            Button {} label: {
                Label("Use Current Location", systemImage: "location.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            
            if isSearching { ProgressView("Searching…") }
            if let error { Text(error).foregroundColor(.red).font(.footnote) }
            
            List(results, id: \.self) { sel in
                Button { onSelect(sel) } label: {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text(sel.name)
                        Spacer()
                        Text("\(sel.lat, specifier: "%.3f"), \(sel.lon, specifier: "%.3f")")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
        .padding()
    }
}
