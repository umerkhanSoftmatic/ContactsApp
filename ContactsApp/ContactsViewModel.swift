import Foundation
import SwiftUI

class ContactsViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    
    private let userDefaultsKey = "contacts_key" //To store and retrieve contact data from UserDefaults.
    
    init() {
        fetchContacts()
    }
    
    func fetchContacts() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let savedContacts = try? JSONDecoder().decode([Contact].self, from: data) {
            contacts = savedContacts // If decoding is successful, contacts is updated with the retrieved contacts.
        }
    }
    
    func saveContacts() {
        if let encodedData = try? JSONEncoder().encode(contacts) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        } // saves the encoded data with the specified key.
    }
    

    func addContact(_ contact: Contact) {
        var newContact = contact
        newContact.dateAdded = Date.now
        contacts.append(newContact)
        saveContacts()
    }
    
    func deleteContact(at offsets: IndexSet) {
        contacts.remove(atOffsets: offsets)
        saveContacts()
    }
    
    func updateContact(_ contact: Contact) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) { //Finds the index of the contact to be updated using its id.
            var updatedContact = contact
            updatedContact.dateEdited = Date.now
            contacts[index] = updatedContact
            saveContacts()
        }
    }
    

    
    func filteredContacts(searchText: String, showFavorites: Bool, sortOption: String, selectedCategory: String) -> [Contact] {
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
