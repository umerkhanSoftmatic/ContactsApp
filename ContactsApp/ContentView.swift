import SwiftUI

struct ContactsView: View {
    @StateObject private var viewModel = ContactsViewModel()
    @StateObject private var filterViewModel = FilterViewModel()
    @State private var selectedContact: Contact? = nil
    @State private var isEditing = false
    @State private var showDeleteConfirmation = false
    @State private var contactToDelete: Contact?

    var body: some View {
        NavigationView {
            VStack {
                FilterPickerView(showFavorites: $filterViewModel.showFavorites)
                
                // Search Bar
                SearchView(searchText: Binding(
                    get: {
                        if case let .text(searchText) = filterViewModel.searchFilter {
                            return searchText
                        }
                        return ""
                    },
                    set: { newValue in
                        filterViewModel.searchFilter = newValue.isEmpty ? .none : .text(newValue)
                    }
                ))
                
                // Contact List
                ContactListView(
                    viewModel: viewModel,
                    selectedContact: $selectedContact,
                    isEditing: $isEditing,
                    contactToDelete: $contactToDelete,
                    showDeleteConfirmation: $showDeleteConfirmation,
                    filteredContacts: filterViewModel.filterContacts(contacts: viewModel.contacts) // Pass filteredContacts last
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
                    ToolBarItemsView(
                        sortOption: $filterViewModel.sortOption,
                        selectedCategory: $filterViewModel.selectedCategory
                    )
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
