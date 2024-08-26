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
    var isEditing: Bool = false
    @Published var profileImage: UIImage? = nil  // Added this to store the selected image
    
    init(contact: Contact? = nil) {
        if let contact = contact {
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
    
    func createContact() -> Contact {  //This method compiles the current state of the form into a new Contact object. It is called when the user submits the form to either add a new contact or save changes to an existing contact.
        return Contact(
            id: UUID(),
            name: name,
            phone: phone,
            email: email,
            address1: address1,
            address2: address2.isEmpty ? nil : address2,
            isFavorite: isFavorite,
            category: category,
            dateAdded: dateAdded,
            dateEdited: dateEdited,
            profileImageData: profileImage?.jpegData(compressionQuality: 1.0)  // Save the image as data
        )
        //All properties of the Contact struct are filled with the current state of the form's fields.
                
                //In summary, this ensures that each contact entry is comprehensive, accurate, and ready for further processing, storage, or display within the app.
    }
}
