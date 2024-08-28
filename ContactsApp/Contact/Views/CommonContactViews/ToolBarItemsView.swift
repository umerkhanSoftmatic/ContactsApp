import SwiftUI

struct ToolBarItemsView: View {
    @Binding var sortOption: SortOption
    @Binding var selectedCategory: CategoryFilter
    
    var body: some View {
        // Sort Option Picker
        Picker("Sort", selection: $sortOption) {
            ForEach(SortOption.allCases, id: \.self) { option in
                Text(option.rawValue).tag(option)
            }
        }
        .pickerStyle(MenuPickerStyle())
        .padding(.trailing, 85)
        .padding()
        
        // Category Picker
        Picker("Category", selection: $selectedCategory) {
            ForEach(CategoryFilter.allCases, id: \.self) { category in
                Text(category.rawValue).tag(category)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
}
