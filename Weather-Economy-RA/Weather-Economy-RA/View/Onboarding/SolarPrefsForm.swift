import SwiftUI

struct SolarPrefsForm: View {
    @State var prefs: SolarPrefs
    var onSave: (SolarPrefs) -> Void

    var body: some View {
        Form {
            Section("Solar Setup") {
                HStack {
                    Text("Capacity")
                    Spacer()
                    TextField(
                        "kWp",
                        value: $prefs.capacityKwp,
                        format: .number.precision(.fractionLength(2))
                    )
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    Text("kWp")
                }
                
                HStack {
                    Text("Efficiency")
                    Spacer()
                    TextField(
                        "",
                        value: $prefs.efficiency,
                        format: .number.precision(.fractionLength(2))
                    )
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                }
            }

            Section("Economy") {
                HStack {
                    Text("Tariff")
                    Spacer()
                    TextField(
                        "€/kWh",
                        value: $prefs.tariffEurPerKwh,
                        format: .number.precision(.fractionLength(2))
                    )
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    Text("€/kWh")
                }
            }
        }
        Button("Save") { onSave(prefs) }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.horizontal)
    }
}
