import SwiftUI

struct ToolBarItemsView: View {
    
    @Binding var sortOption: String
    @Binding var selectedCategory: String
    
    let categories = ["All","Home", "Office", "Friends"]
    let sortOptions = ["Recently Edited", "A-Z", "Z-A"]
    
    var body: some View {
                
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
    
