import SwiftUI

struct ContactsView: View {
    @StateObject private var viewModel = ContactsViewModel()
    
    @State private var searchText = ""
    @State private var showFavorites = false
    @State private var sortOption = "Recently Edited"
    @State private var selectedCategory = "All"
    @State private var selectedContact: Contact? = nil
    @State private var isEditing = false
    @State private var showDeleteConfirmation = false
    @State private var contactToDelete: Contact?
    
    let categories = ["All","Home", "Office", "Friends"]
    let sortOptions = ["Recently Edited", "A-Z", "Z-A"]
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Filter", selection: $showFavorites) {
                                    Text("All").tag(false)
                                    Text("Favorites").tag(true)
                                }
                .pickerStyle(SegmentedPickerStyle())
                                .padding()
                // Search Bar
                TextField(" 🔎 Search Contacts", text: $searchText)
                    .padding([.top, .bottom],12)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(20)
                    .padding(.horizontal)


                // Contact List
                List {
                    ForEach(viewModel.filteredContacts(searchText: searchText, showFavorites: showFavorites, sortOption: sortOption, selectedCategory: selectedCategory)) { contact in
                        ContactCardView(contact: contact, onFavoriteToggle: { updatedContact in //This closure handles the toggle action for marking a contact as a favorite.
                            viewModel.updateContact(updatedContact) //UI reflects the favorite toggle change.
                        })
                        .swipeActions(edge: .trailing) {
                                                    Button(role: .destructive) {
                                                        contactToDelete = contact
                                                        showDeleteConfirmation = true
                                                    } label: {
                                                        Image(systemName: "trash")
                                                    }
                                                    .tint(.red)
                            
                            Button {
                                selectedContact = contact
                                isEditing = true
                                viewModel.updateContact(contact)
                                viewModel.saveContacts()
                                
                            } label: {
                                Image(systemName: "pencil")
                            }
                            .tint(.blue)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                
                // Add Contact Button
                HStack {
                    Spacer()
                    NavigationLink(destination: ContactFormView(viewModel: ContactFormViewModel(), contactsViewModel: viewModel, contact: nil)) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .padding()
                            .background(Color(hue: 0.667, saturation: 0.966, brightness: 0.805))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding(.bottom,-20)
                    .padding(.trailing,10)
                }
                
                // NavigationLink for Editing
                NavigationLink(destination: ContactFormView(viewModel: ContactFormViewModel(), contactsViewModel: viewModel, contact: selectedContact), isActive: $isEditing) {
                    EmptyView()
                }
                
                //Passes the currently selected contact (if any) to the form. This is used to populate the form fields with the existing data for editing or left empty for a new contact.

            }
            .navigationTitle("Contacts📓")
            
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    // Sort Option Picker
                    Picker("Sort", selection: $sortOption) {
                        ForEach(sortOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.trailing,85)
                    .padding()
                    
                    
                    // Category Picker
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                
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
                        if let contact = contactToDelete {
                            if let index = viewModel.contacts.firstIndex(where: { $0.id == contact.id }) {
                                viewModel.deleteContact(at: IndexSet(integer: index))
                            }
                        }
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
