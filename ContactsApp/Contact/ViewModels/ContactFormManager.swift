import Foundation

struct ContactFormManager {
    func isFormValid(for viewModel: ContactFormViewModel) -> Bool {
        return isValidField(viewModel.name) &&
               isValidField(viewModel.phone) &&
               isValidField(viewModel.email) &&
               isValidField(viewModel.address1) &&
               isValidPhoneNumber(viewModel.phone)
    }
    
    private func isValidField(_ field: String) -> Bool {
        return field.count >= 3
    }
    
    private func isValidPhoneNumber(_ phone: String) -> Bool {
        let digitsOnlyCharacterSet = CharacterSet.decimalDigits
        let phoneCharacterSet = CharacterSet(charactersIn: phone)
        return digitsOnlyCharacterSet.isSuperset(of: phoneCharacterSet)
    }
}
