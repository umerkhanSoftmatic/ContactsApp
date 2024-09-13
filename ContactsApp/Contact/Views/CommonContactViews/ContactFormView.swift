import SwiftUI

struct ContactFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: ContactFormViewModel
    @StateObject var viewModels: AddFiltersViewModel
    @ObservedObject var contactsViewModel: ContactsViewModel
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil
    
    let Valid = ContactFormManager()
    
    var contact: Contact?

    var body: some View {
        VStack {
            
            FormView(viewModel: viewModel, viewModels: viewModels, selectedImage: $selectedImage , showImagePicker: $showImagePicker)
            
            Button(action: {
                viewModel.profileImage = selectedImage
                viewModel.updatedContacts(contactsViewModel: contactsViewModel)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text(viewModel.isEditing ? "Save" : "Add")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .disabled(!Valid.isFormValid(for: viewModel))
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
    

}
