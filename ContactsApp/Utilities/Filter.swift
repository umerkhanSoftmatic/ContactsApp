import Foundation

struct Filter {
     func filteredContacts(
        contacts: [Contact],
        searchText: String,
        showFavorites: Bool,
        sortOption: String,
        selectedCategory: String
    ) -> [Contact] {
        var filtered = contacts
        
        // Filter by search text
        if !searchText.isEmpty {
            filtered = filtered.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
        
        // Filter by favorites
        if showFavorites {
            filtered = filtered.filter { $0.isFavorite }
        }
        
        // Filter by category
        if selectedCategory != "All" {
            filtered = filtered.filter { $0.category == selectedCategory }
        }
        
        // Sort by selected option
        switch sortOption {
        case "A-Z":
            filtered.sort { $0.name < $1.name }
        case "Z-A":
            filtered.sort { $0.name > $1.name }
        case "Recently Added":
            filtered.sort { $0.dateAdded > $1.dateAdded }
        case "Recently Edited":
            filtered.sort { ($0.dateEdited ?? $0.dateAdded) > ($1.dateEdited ?? $1.dateAdded) }
        default:
            break
        }
        
        return filtered
    }
}
