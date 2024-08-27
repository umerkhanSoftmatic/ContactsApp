import SwiftUI

struct ContactListView: View {
    @ObservedObject var viewModel: ContactsViewModel
    @Binding var selectedContact: Contact?
    @Binding var isEditing: Bool
    @Binding var contactToDelete: Contact?
    @Binding var showDeleteConfirmation: Bool

    var body: some View {
        List {
            ForEach(viewModel.filteredContacts) { contact in
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
