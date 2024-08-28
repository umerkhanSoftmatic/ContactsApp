import SwiftUI

struct FormView: View {
    @StateObject var viewModel: ContactFormViewModel
    @Binding var selectedImage: UIImage?
    @Binding var showImagePicker: Bool
    @State private var showAddCategorySheet = false
    @State var customCategories: [String] = []

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

            Section(header: Text("Contact Information")) {
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Phone", text: $viewModel.phone)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Address 1", text: $viewModel.address1)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Address 2", text: $viewModel.address2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            Section(header: Text("Category")) {
                Picker("Category", selection: $viewModel.category) {
                
                    ForEach(CategoryFilter.allCases, id: \.self) { category in
                        Text(category.rawValue).tag(category.rawValue)
                    }
                    
                    // Custom categories
                    ForEach(customCategories, id: \.self) { customCategory in
                        Text(customCategory).tag(customCategory)
                    }
                }
                .pickerStyle(MenuPickerStyle())

                Button(action: {
                    showAddCategorySheet.toggle()
                }) {
                    Text("Add Custom Category")
                        .foregroundColor(.blue)
                }
            }
        }
        .navigationTitle("Contact Form")
        .sheet(isPresented: $showAddCategorySheet) {
            AddCategorySheet(customCategories: $customCategories)
                }
    }
}
