import Foundation
import SwiftUI

class ContactsViewModel: ObservableObject {
    
    @Published var contacts: [Contact] = []
    @Published var contactToDelete: Contact?
    @Published var isFavortie : Bool = false
    
    
    var allContacts : [Contact] = []
    
    let userdefaultsDB = UserDefaultsManager.shared
    
    init() 
    {
        fetchContacts()
    }
    
    func fetchContacts() 
    {
        contacts = userdefaultsDB.fetchContacts()
        allContacts = contacts
    }
    
    func addContact(_ contact: Contact)
    {
       allContacts.append(contact)
       contacts.append(contact)
       saveContacts()
    }
    
    func updateContact(_ contact: Contact)
    {
        if self.isFavortie
        {
            self.refereshListOnUnfoavite(contact)
        }
       userdefaultsDB.updateContact(contacts: &self.allContacts,contact)
    }
    

    func deleteContact()
    {
        if let contact = contactToDelete
        {
            userdefaultsDB.deleteContact(contacts: &self.allContacts, contactToDelete: contact)
            contactToDelete = nil
        }
        fetchContacts()
    }
    
    func saveContacts()
    {
        userdefaultsDB.saveContacts(allContacts)
    }


    
    func showFavouriteContacts(isFavorite : Bool)
    {
        if isFavorite
        {
            self.contacts = self.allContacts.filter({$0.isFavorite})
        }
        else
        {
            contacts = allContacts
        }
    }
    
    func refereshListOnUnfoavite(_ contact: Contact)
    {
        if !contact.isFavorite
        {
            if let index = contacts.firstIndex(where: {$0.id == $0.id})
            {
                contacts.remove(at: index)
            }
        }
    }
    
    func searchContact(searchText: String)
    {
        if searchText.isEmpty
        {
            contacts = allContacts
        }
        else
        {
            self.contacts = self.allContacts.filter({$0.name.lowercased().contains(searchText.lowercased())})
        }
    }
    
    func filterContactsForCategory(categoryName : String)
    {
        if categoryName == "All"
        {
            contacts = allContacts
        }
        else
        {
            contacts = allContacts.filter({$0.category?.lowercased() ?? "" == categoryName.lowercased()})
        }
        
    }
    
    
    func SortingFilter(_ contacts: [Contact], sortOption: SortOption) {
            switch sortOption {
            case .aToZ:
                self.contacts = contacts.sorted { $0.name < $1.name }
            case .zToA:
                self.contacts = contacts.sorted { $0.name > $1.name }
            case .recentlyEdited:
                self.contacts = contacts.sorted { ($0.dateEdited ?? $0.dateAdded) > ($1.dateEdited ?? $1.dateAdded) }
            }
        }
    
}
