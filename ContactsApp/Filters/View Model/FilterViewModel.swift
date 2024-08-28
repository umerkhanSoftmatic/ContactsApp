import Foundation
import SwiftUI

class FilterViewModel: ObservableObject {
    @Published var searchFilter: SearchFilter = .none
    @Published var showFavorites: Bool = false
    @Published var sortOption: SortOption = .recentlyEdited
    @Published var selectedCategory: CategoryFilter = .all

    func filterContacts(
        contacts: [Contact]
    ) -> [Contact] {
        let filter = Filter() 
        return filter.filteredContacts(
            contacts: contacts,
            searchFilter: searchFilter,
            showFavorites: showFavorites,
            sortOption: sortOption,
            selectedCategory: selectedCategory
        )
    }
}
