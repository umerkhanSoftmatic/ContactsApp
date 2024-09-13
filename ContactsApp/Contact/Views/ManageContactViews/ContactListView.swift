import SwiftUI

struct ContactListView: View {
   
    @ObservedObject var viewModel: ContactsViewModel
    @StateObject private var vm = ContactFormViewModel()
   
    
    @Binding var selectedContact: Contact?
    @Binding var isEditing: Bool
    @Binding var showDeleteConfirmation: Bool

    var body: some View {
        List {
            ForEach(viewModel.contacts) { contact in
                ContactCardView(contact: contact, onFavoriteToggle: { updatedContact in
                    viewModel.updateContact(updatedContact)
                })
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        viewModel.contactToDelete = contact
                        showDeleteConfirmation = true
                    } label: {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                    
                    Button {
                        selectedContact = contact
                        isEditing = true
                        //viewModel.updateContact(contact)
//                        if let index = contact.firstIndex(where: {$0.id == $0.id})
//                        {
//                            //contact.update()
//                        }
                        vm.updatedContacts(contactsViewModel: viewModel)
                    } label: {
                        Image(systemName: "pencil")
                    }
                    .tint(.blue)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}
