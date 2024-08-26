import SwiftUI

struct ContactFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: ContactFormViewModel
    @ObservedObject var contactsViewModel: ContactsViewModel
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil

    var contact: Contact?

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Profile Picture")) {
                    VStack {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                        Button(action: {
                            showImagePicker.toggle()
                        }) {
                            Text("Add a Picture")
                        }
                        .padding(.top, 10)
                    }
                }

                TextField("Name", text: $viewModel.name)
                TextField("Phone", text: $viewModel.phone)
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                TextField("Address 1", text: $viewModel.address1)
                TextField("Address 2", text: $viewModel.address2)
                
                Picker("Category", selection: $viewModel.category) {
                    ForEach(["Home", "Office", "Friends"], id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
            }
            
            Button(action: {
                viewModel.profileImage = selectedImage
                let updatedContact = viewModel.createContact()
                if viewModel.isEditing {
                    contactsViewModel.updateContact(updatedContact)
                } else {
                    contactsViewModel.addContact(updatedContact)
                }
                presentationMode.wrappedValue.dismiss()
            }) {
                Text(viewModel.isEditing ? "Save" : "Add")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .disabled(!isFormValid())
        }
        .navigationTitle(viewModel.isEditing ? "Edit Contact" : "Add Contact")
        .onAppear {
            if let contact = contact {
                viewModel.loadContactData(contact: contact)
            }
            selectedImage = viewModel.profileImage  // Set the image if it exists
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage, isShown: $showImagePicker)
        }
        
    }
    
    private func isFormValid() -> Bool {
        !viewModel.name.isEmpty &&
        !viewModel.phone.isEmpty &&
        !viewModel.email.isEmpty &&
        !viewModel.address1.isEmpty
    }
}


