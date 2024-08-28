import SwiftUI

struct AddCategorySheet: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = NewCategoryViewModel()
    @Binding var customCategories: [String]
    @State var newCategory: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Add New Category")) {
                    TextField("Category Name", text: $newCategory)
                }
                Section {
                    Button("Add Category") {
                        viewModel.addCategory(newCategory)
                       // newCategory.append(customCategories)
                        customCategories.append(newCategory)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(newCategory.isEmpty)
                }
            }
            .navigationTitle("Add Category")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}


