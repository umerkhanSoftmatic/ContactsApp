
import SwiftUI

struct AddContactButtonView: View {
    @ObservedObject var viewModel: ContactsViewModel
    
    var body: some View {
       
        NavigationLink(destination: ContactFormView(viewModel: ContactFormViewModel(), contactsViewModel: viewModel)) {
            Image(systemName: "plus.circle.fill")
                .font(.largeTitle)
                .padding()
                .background(Color(hue: 0.667, saturation: 0.966, brightness: 0.805))
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        .padding(.bottom,-20)
        .padding(.trailing,10)    }
}

#Preview {
    AddContactButtonView(viewModel: ContactsViewModel())
}
