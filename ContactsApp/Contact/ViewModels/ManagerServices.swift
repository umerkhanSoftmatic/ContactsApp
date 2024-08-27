import Foundation
import UIKit

struct ManagerServices {
    
    func createContact(from viewModel: ContactFormViewModel) -> Contact {
        return Contact(
            id: UUID(),
            name: viewModel.name,
            phone: viewModel.phone,
            email: viewModel.email,
            address1: viewModel.address1,
            address2: viewModel.address2.isEmpty ? nil : viewModel.address2,
            isFavorite: viewModel.isFavorite,
            category: viewModel.category,
            dateAdded: viewModel.dateAdded,
            dateEdited: viewModel.dateEdited,
            profileImageData: viewModel.profileImage?.jpegData(compressionQuality: 1.0)  // Save the image as data
        )
    }
    
    
    func deleteContact(from viewModel: ContactsViewModel, at offsets: IndexSet) {
        viewModel.contacts.remove(atOffsets: offsets)
        viewModel.saveContacts()
    }
    
    
    func updateContact(from viewModel: ContactsViewModel, with contact: Contact) {
        if let index = viewModel.contacts.firstIndex(where: { $0.id == contact.id }) {
            var updatedContact = contact
            updatedContact.dateEdited = Date.now
            viewModel.contacts[index] = updatedContact
            viewModel.saveContacts()
        }
    }
    
    
    func addContact(from viewModel: ContactsViewModel, with contact: Contact) {
        var newContact = contact
        newContact.dateAdded = Date.now
        viewModel.contacts.append(newContact)
        viewModel.saveContacts()
    }
    
}




