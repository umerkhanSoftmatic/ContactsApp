import Foundation
import SwiftUI

class FilterViewModel: ObservableObject {
    @Published var searchFilter: SearchFilter = .none
    @Published var showFavorites: Bool = false
    @Published var sortOption: SortOption = .recentlyEdited
    @Published var selectedCategory = "All"//: CategoryFilter = .all
    @Published var categories: [String] = []
    let userdefaultsDB = UserDefaultsManager.shared
   // private var dataServices = DataServices()

    init() {
       // loadCategories()
    }

    func loadCategories() {
        categories = userdefaultsDB.fetchCategories()
        
    }

    func saveCategories() {
        userdefaultsDB.saveCategories(categories)
    }

//    func filterContacts(contacts: [Contact]) -> [Contact] {
//        let filter = Filter()
//        return filter.filteredContacts(
//            contacts: contacts,
//            searchFilter: searchFilter,
//            showFavorites: showFavorites,
//            sortOption: sortOption,
//            selectedCategory: selectedCategory
//        )
//    }
    
    func updateCategories(from viewModel: AddFiltersViewModel) {
        self.categories = viewModel.categories 
        saveCategories()
    }


}
