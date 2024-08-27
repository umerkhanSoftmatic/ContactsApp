import SwiftUI

struct ContactsView: View {
    @StateObject private var viewModel = ContactsViewModel()
    @State private var selectedContact: Contact? = nil
    @State private var isEditing = false
    @State private var showDeleteConfirmation = false
    @State private var contactToDelete: Contact?
    
    var body: some View {
        NavigationView {
            VStack {
                FilterPickerView(showFavorites: $viewModel.showFavorites)
                
                // Search Bar
                SearchView(searchText: $viewModel.searchText)
                    .onChange(of: viewModel.searchText) { newValue in
                        viewModel.filterContacts()
                    }

                // Contact List
                ContactListView(
                    viewModel: viewModel,
                    selectedContact: $selectedContact,
                    isEditing: $isEditing,
                    contactToDelete: $contactToDelete,
                    showDeleteConfirmation: $showDeleteConfirmation
                )
                
                // Add Contact Button
                HStack {
                    Spacer()
                    AddContactButtonView(viewModel: viewModel)
                }
                
                // NavigationLink for Editing
                NavigationLink(destination: ContactFormView(viewModel: ContactFormViewModel(), contactsViewModel: viewModel, contact: selectedContact), isActive: $isEditing) {
                    EmptyView()
                }
            }
            .navigationTitle("Contacts📓")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    ToolBarItemsView(sortOption: $viewModel.sortOption, selectedCategory: $viewModel.selectedCategory)
                }
            }
            .onAppear {
                viewModel.fetchContacts()
            }
            .alert(isPresented: $showDeleteConfirmation) {
                Alert(
                    title: Text("Delete Contact"),
                    message: Text("Are you sure you want to delete this contact?"),
                    primaryButton: .destructive(Text("Delete")) {
                        viewModel.deleteConfirmation()
                        contactToDelete = nil
                    },
                    secondaryButton: .cancel {
                        contactToDelete = nil
                    }
                )
            }
        }
    }
}

#Preview {
    ContactsView()
}
