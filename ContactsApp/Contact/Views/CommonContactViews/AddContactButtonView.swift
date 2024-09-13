import SwiftUI

struct AddContactButtonView: View {
    @ObservedObject var viewModel: ContactsViewModel
    @ObservedObject var viewModels: AddFiltersViewModel
    
    var body: some View {
        NavigationLink(destination: ContactFormView(
            viewModel: ContactFormViewModel(),
            viewModels: viewModels, 
            contactsViewModel: viewModel
        )) {
            Image(systemName: "plus.circle.fill")
                .font(.largeTitle)
                .padding()
                .background(Color(hue: 0.667, saturation: 0.966, brightness: 0.805))
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        .padding(.bottom, -20)
        .padding(.trailing, 10)
    }
}
