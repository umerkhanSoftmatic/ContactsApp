import Foundation

struct Filter {
    func filteredContacts(
        contacts: [Contact],
        searchFilter: SearchFilter,
        showFavorites: Bool,
        sortOption: SortOption,
        selectedCategory: CategoryFilter
    ) -> [Contact] {
        var filtered = contacts
        
        
        if searchFilter != .none {
            filtered = applySearchFilter(to: filtered, searchFilter: searchFilter)
        }
        if showFavorites {
            filtered = applyFavoritesFilter(to: filtered)
        }
        if selectedCategory != .all {
            filtered = applyCategoryFilter(to: filtered, selectedCategory: selectedCategory)
        }
        filtered = applySorting(to: filtered, sortOption: sortOption)
        
        return filtered
    }
    
    private func applySearchFilter(to contacts: [Contact], searchFilter: SearchFilter) -> [Contact] {
        switch searchFilter {
        case .none:
            return contacts
        case .text(let searchText):
            return contacts.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    private func applyFavoritesFilter(to contacts: [Contact]) -> [Contact] {
        return contacts.filter { $0.isFavorite }
    }
    
    private func applyCategoryFilter(to contacts: [Contact], selectedCategory: CategoryFilter) -> [Contact] {
        return contacts.filter { $0.category == selectedCategory.rawValue }
    }
    
    private func applySorting(to contacts: [Contact], sortOption: SortOption) -> [Contact] {
        switch sortOption {
        case .aToZ:
            return contacts.sorted { $0.name < $1.name }
        case .zToA:
            return contacts.sorted { $0.name > $1.name }
        case .recentlyEdited:
            return contacts.sorted { ($0.dateEdited ?? $0.dateAdded) > ($1.dateEdited ?? $1.dateAdded) }
        }
    }
}
