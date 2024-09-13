import Foundation

enum UserDefaultsManagerKeys : String{
    case userDefaultsKey = "contacts_key"
    case categoriesKey = "categories_key"
    
}

struct UserDefaultsManager {

    static let shared = UserDefaultsManager()
   
     private init(){}
    
    func fetchContacts() -> [Contact] {
        if let data = UserDefaults.standard.data(forKey: UserDefaultsManagerKeys.userDefaultsKey.rawValue),
           let savedContacts = try? JSONDecoder().decode([Contact].self, from: data) {
            return savedContacts
        }
        return []
    }
    
    func deleteContact(contacts : inout [Contact] , contactToDelete : Contact){
      //  contacts.removeAll(where: {$0.id == contactToDelete.id})
        if let index = contacts.firstIndex(where: { $0.id == contactToDelete.id }) {
            contacts.remove(at: index)
            saveContacts(contacts)
        }
    }
    

    func saveContacts(_ contacts: [Contact]) {
        if let encodedData = try? JSONEncoder().encode(contacts) {
            UserDefaults.standard.set(encodedData, forKey: UserDefaultsManagerKeys.userDefaultsKey.rawValue)
        } // Saves the encoded data with the specified key.
    }
    
    
    func updateContact(contacts : inout [Contact] ,_ updatedContact: Contact) {
        
        if let index = contacts.firstIndex(where: { $0.id == updatedContact.id }) {
            contacts[index] = updatedContact
        }
        saveContacts(contacts)
    }

    
  
    func fetchCategories() -> [String] {
        if let categories = UserDefaults.standard.stringArray(forKey: UserDefaultsManagerKeys.categoriesKey.rawValue) {
            return categories
        }
        return ["All", "Home", "Office", "Friends"]
    }
    
    
    func saveCategories(_ categories: [String]) {
        UserDefaults.standard.set(categories, forKey: UserDefaultsManagerKeys.categoriesKey.rawValue)
    }
    
    
    
}

