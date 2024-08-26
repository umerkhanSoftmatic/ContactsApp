import SwiftUI

@main
struct ContactsAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContactsView()
                .environmentObject(ContactsViewModel())
            
        } // we have used the environmentObject modifier to inject the ContactsViewModel into the SwiftUI environment. This allows any view within the WindowGroup to access the ContactsViewModel instance.
    }
}

