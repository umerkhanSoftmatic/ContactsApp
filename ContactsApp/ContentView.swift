import SwiftUI

struct ContactsView: View {
   
    @StateObject private var viewModel = ContactsViewModel()
    @StateObject private var filterViewModel = FilterViewModel()
    @StateObject private var addFiltersViewModel = AddFiltersViewModel()
    //@StateObject private var vm = ContactFormViewModel()
    @State private var selectedContact: Contact? = nil
    @State private var isEditing = false
    @State private var showDeleteConfirmation = false
    @State private var contactToDelete: Contact?
    @State private var showAddFilters = false
    @State var searchText = ""
   
    
    var body: some View {
        NavigationView {
            VStack {
                FilterPickerView(showFavorites: $viewModel.isFavortie)
                    .onChange(of: viewModel.isFavortie) { newValue in
                        viewModel.showFavouriteContacts(isFavorite: newValue)
                    }
                
                SearchView(searchText: $searchText)
                    .onChange(of: searchText) { newValue in
                        viewModel.searchContact(searchText: newValue)
                    }
            
                ContactListView(
                    viewModel: viewModel,
                    selectedContact: $selectedContact,
                    isEditing: $isEditing,
                    showDeleteConfirmation: $showDeleteConfirmation
                )
                
                HStack {
                    Button(action: {
                        showAddFilters.toggle()
                    }) {
                        Text("Add Filter")
                            .foregroundColor(.white)
                            .frame(width: 90, height: 50)
                            .background(Color(hue: 0.667, saturation: 0.966, brightness: 0.805))
                            .clipped()
                            .cornerRadius(30)
                    }
                    .padding(.leading, 5)
                    
                    Spacer()
                    
                    AddContactButtonView(viewModel: viewModel, viewModels: addFiltersViewModel)
                }
                
                NavigationLink(destination: ContactFormView(viewModel: ContactFormViewModel(), viewModels: addFiltersViewModel, contactsViewModel: viewModel, contact: selectedContact), isActive: $isEditing) {
                    EmptyView()
                }
            }
            .navigationTitle("Contacts📓")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    ToolBarItemsView(filterViewModel: self.filterViewModel, viewModel: self.viewModel)
                }
            }
            .onAppear {
                viewModel.fetchContacts()
                filterViewModel.updateCategories(from: addFiltersViewModel)
            }
            .alert(isPresented: $showDeleteConfirmation) {
                Alert(
                    title: Text("Delete Contact"),
                    message: Text("Are you sure you want to delete this contact?"),
                    primaryButton: .destructive(Text("Delete")) {
                        viewModel.deleteContact()
                    },
                    secondaryButton: .cancel {
                        viewModel.contactToDelete = nil
                    }
                )
            }
            

            
            .sheet(isPresented: $showAddFilters) {
                AddFiltersView(viewModels: addFiltersViewModel, doneAddCategory: {
                    filterViewModel.loadCategories()
                    print("do something after adding new category")
                })
            }
        }
    }
}

#Preview {
    ContactsView()
}
