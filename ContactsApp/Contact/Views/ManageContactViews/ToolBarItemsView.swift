import SwiftUI

struct ToolBarItemsView: View {
   
    @ObservedObject var filterViewModel : FilterViewModel
    @ObservedObject var viewModel : ContactsViewModel

    var body: some View {
        // Sort Picker
        
        Picker("Sort", selection: $filterViewModel.sortOption) {
            ForEach(SortOption.allCases, id: \.self) { option in
                Text(option.rawValue).tag(option)
            }
        }
        .pickerStyle(MenuPickerStyle())
        .padding(.trailing, 85)
        .padding()
        
        .onChange(of: filterViewModel.sortOption) { newValue in
           viewModel.SortingFilter(viewModel.contacts, sortOption: newValue)
        }
        
        

       //  Category Picker
        Picker("Category", selection: $filterViewModel.selectedCategory) {
            ForEach(filterViewModel.categories, id: \.self) { category in
                Text(category)
            }
        }
        .pickerStyle(MenuPickerStyle())
        
        .onChange(of: filterViewModel.selectedCategory) { newValue in
            viewModel.filterContactsForCategory(categoryName: newValue)
        }
    }
}
