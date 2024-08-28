import Foundation
import SwiftUI

class ContactsViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    @Published var filteredContacts: [Contact] = []
    @Published var contactToDelete: Contact?
    @ObservedObject private var filterViewModel = FilterViewModel()

    let dataServices = DataServices()
    let managerService = ManagerServices()

    init() {
        fetchContacts()
    }

    func fetchContacts() {
        contacts = dataServices.fetchContacts()
        filterContacts()
    }

    func saveContacts() {
        dataServices.saveContacts(contacts)
    }

    func addContact(_ contact: Contact) {
        managerService.addContact(from: self, with: contact)
        fetchContacts()
    }

    func deleteContact(at offsets: IndexSet) {
        managerService.deleteContact(from: self, at: offsets)
        fetchContacts()
    }

    func updateContact(_ contact: Contact) {
        managerService.updateContact(from: self, with: contact)
        fetchContacts()
    }

    func filterContacts() {
        filteredContacts = filterViewModel.filterContacts(contacts: contacts)
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
