import SwiftUI

struct FilterPickerView: View {
    @Binding var showFavorites: Bool

    var body: some View {
        Picker("Filter", selection: $showFavorites) {
            Text("All").tag(false)
            Text("Favorites").tag(true)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}
