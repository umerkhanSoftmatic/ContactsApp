//MARK: Model

import Foundation
import UIKit

struct Contact: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var phone: String
    var email: String
    var address1: String
    var address2: String?
    var isFavorite: Bool = false
    var category: String?
    var dateAdded: Date = Date.now
    var dateEdited: Date? = nil
    var profileImageData: Data? = nil  // To store the profile image as Data
    
    var profileImage: UIImage? {
        get {
            if let data = profileImageData {
                return UIImage(data: data)
        }
         return nil
        }
        set {
            profileImageData = newValue?.jpegData(compressionQuality: 1.0)
        }
    }
}
