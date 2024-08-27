import SwiftUI

struct SearchView: View {
    @Binding var searchText: String

    var body: some View {
        TextField(" 🔎 Search Contacts", text: $searchText)
            .padding([.top, .bottom], 12)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
            .padding(.horizontal)
    }
}
