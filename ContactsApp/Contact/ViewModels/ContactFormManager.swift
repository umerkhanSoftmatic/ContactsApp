import Foundation

struct ContactFormManager {
    func isFormValid(for viewModel: ContactFormViewModel) -> Bool 
    {
        return !viewModel.name.isEmpty &&
               !viewModel.phone.isEmpty &&
               !viewModel.email.isEmpty &&
               !viewModel.address1.isEmpty
    }
}
