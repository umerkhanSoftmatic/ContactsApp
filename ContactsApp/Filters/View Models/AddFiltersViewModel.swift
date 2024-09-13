import Foundation

class AddFiltersViewModel: ObservableObject {
   
    @Published var categories: [String]
    let userdefaultsDB = UserDefaultsManager.shared
  //  private let dataServices = DataServices()
    
    init() {
        // Load categories from UserDefaults
        self.categories = userdefaultsDB.fetchCategories()
    }

    func addCategory(_ category: String) {
        categories.append(category)
        saveCategories()
    }

    func deleteCategory(at offsets: IndexSet) {
        categories.remove(atOffsets: offsets)
        saveCategories()
    }
    

     func saveCategories() {
         userdefaultsDB.saveCategories(categories)
    }
}
