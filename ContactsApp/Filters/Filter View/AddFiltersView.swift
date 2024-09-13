import SwiftUI

struct AddFiltersView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModels = AddFiltersViewModel()
    @State private var newCategory: String = ""
    let doneAddCategory : () -> Void

    var body: some View {
        VStack {
            List {
                ForEach(viewModels.categories, id: \.self) { category in
                    Text(category)
                }
                .onDelete(perform: viewModels.deleteCategory)
            }
            
            HStack {
                TextField("New Category", text: $newCategory)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    if !newCategory.isEmpty {
                        viewModels.addCategory(newCategory)
                        self.doneAddCategory()
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Add")
                }
                
                .padding()
                
                
            }
        }
        .navigationTitle("Add Filters")

    }
}
