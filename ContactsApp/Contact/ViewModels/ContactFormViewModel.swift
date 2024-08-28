import Foundation
import UIKit

class ContactFormViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var phone: String = ""
    @Published var email: String = ""
    @Published var address1: String = ""
    @Published var address2: String = ""
    @Published var isFavorite: Bool = false
    @Published var category: String = "All"
    @Published var dateAdded: Date = Date.now
    @Published var dateEdited: Date? = nil
    @Published var profileImage: UIImage? = nil
    
    

    
    var isEditing: Bool = false
    let managerService = ManagerServices()
    
    
    
    init(contact: Contact? = nil) {
        if let contact = contact {
            self.loadContactData(contact: contact)
        }
    }
    
    
    
    func loadContactData(contact: Contact) {
        self.name = contact.name
        self.phone = contact.phone
        self.email = contact.email
        self.address1 = contact.address1
        self.address2 = contact.address2 ?? ""
        self.isFavorite = contact.isFavorite
        self.category = contact.category ?? "All"
        self.dateAdded = contact.dateAdded
        self.dateEdited = contact.dateEdited
        self.isEditing = true
        self.profileImage = contact.profileImage  // Load the image
    }
    
    
    func createContact() -> Contact {
        return managerService.createContact(from: self)
    }
    
    
    func updatedContacts(contactsViewModel: ContactsViewModel) {
            let updatedContact = createContact()
            if isEditing {
                contactsViewModel.updateContact(updatedContact)
            } else {
                contactsViewModel.addContact(updatedContact)
            }
        }
    
}
