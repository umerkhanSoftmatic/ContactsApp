import Foundation
import SwiftUI

class ContactsViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    @Published var filteredContacts: [Contact] = []
    @Published var contactToDelete: Contact?
    
    @Published var searchText: String = "" {
        didSet {
            filterContacts()
        }
    }
    
    @Published var showFavorites: Bool = false {
        didSet {
            filterContacts()
        }
    }
    
    @Published var sortOption: String = "Recently Edited" {
        didSet {
            filterContacts()
        }
    }
    
    @Published var selectedCategory: String = "All" {
        didSet {
            filterContacts()
        }
    }
    
    let dataServices = DataServices()
    let filter = Filter()
    let managerService = ManagerServices()
    
    init() {
        fetchContacts()
    }
    
    func fetchContacts() {
        contacts = dataServices.fetchContacts()
        filteredContacts = contacts
        filterContacts()
    }
    
    func saveContacts() {
        dataServices.saveContacts(contacts)
    }
    
    func addContact(_ contact: Contact) {
        managerService.addContact(from: self, with: contact)
        filterContacts()
    }
    
    func deleteContact(at offsets: IndexSet) {
        managerService.deleteContact(from: self, at: offsets)
        filterContacts()
    }
    
    func updateContact(_ contact: Contact) {
        managerService.updateContact(from: self, with: contact)
        filterContacts()
    }
    
    
    func filterContacts() {
        filteredContacts = filter.filteredContacts(
            contacts: contacts,
            searchText: searchText,
            showFavorites: showFavorites,
            sortOption: sortOption,
            selectedCategory: selectedCategory
        )

    }

    func deleteConfirmation() {
            if let contact = contactToDelete {
                if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
                    deleteContact(at: IndexSet(integer: index))
                }
                contactToDelete = nil
            }

        }
}
