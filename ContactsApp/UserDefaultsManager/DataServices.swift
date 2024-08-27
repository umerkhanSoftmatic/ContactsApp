import Foundation

struct DataServices {
    private let userDefaultsKey = "contacts_key" // To store and retrieve contact data from UserDefaults.

    func fetchContacts() -> [Contact] {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let savedContacts = try? JSONDecoder().decode([Contact].self, from: data) {
            return savedContacts
        }
        return []
    }

    func saveContacts(_ contacts: [Contact]) {
        if let encodedData = try? JSONEncoder().encode(contacts) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        } // Saves the encoded data with the specified key.
    }
}
