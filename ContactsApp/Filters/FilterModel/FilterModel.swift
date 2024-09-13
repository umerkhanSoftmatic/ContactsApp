
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
    
    init(category: String) {
            if let filter = CategoryFilter(rawValue: category) {
                self = filter
            } else {
                self = .all 
            }
        }
}

enum SortOption: String, CaseIterable {
    case recentlyEdited = "Recently Edited"
    case aToZ = "A-Z"
    case zToA = "Z-A"
}
