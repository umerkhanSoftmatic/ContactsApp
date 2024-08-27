import SwiftUI

struct FormView: View {
    @StateObject var viewModel: ContactFormViewModel
    @Binding var selectedImage: UIImage?
    @Binding var showImagePicker: Bool

    var body: some View {
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
    }
}
