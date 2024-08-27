import SwiftUI

struct ContactCardView: View {
    @State var contact: Contact
    let onFavoriteToggle: (Contact) -> Void
    
    var body: some View {
        HStack {
            if let image = contact.profileImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .foregroundColor(.white)
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading) {
                Text(contact.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(contact.phone)
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            Spacer()
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(contact.isFavorite ? .yellow : .white)
                .onTapGesture {
                    contact.isFavorite.toggle()
                    onFavoriteToggle(contact)
                }
        }
        .padding()
        .background(Color(hue: 0.667, saturation: 0.966, brightness: 0.805))
        .cornerRadius(25)
        .shadow(radius: 10)
        .padding(.horizontal, 5)
    }
}
