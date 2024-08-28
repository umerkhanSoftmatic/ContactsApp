
import Foundation

enum SearchFilter: Equatable {
    case none
    case text(String)
}

enum CategoryFilter: String, CaseIterable {
    case all = "All"
    case home = "Home"
    case office = "Office"
    case friends = "Friends"
}

enum SortOption: String, CaseIterable {
    case recentlyEdited = "Recently Edited"
    case aToZ = "A-Z"
    case zToA = "Z-A"
}
