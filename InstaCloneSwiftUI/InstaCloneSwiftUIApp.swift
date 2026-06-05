import SwiftUI
import FirebaseCore

@main
struct InstaCloneSwiftUIApp: App {

   
    
    @StateObject var auth = AuthViewModel()
    init() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
    var body: some Scene {
        WindowGroup {
            if auth.isLoggedIn {
                HomePage()
                    .environmentObject(auth)
            } else {
                LoginView()
                    .environmentObject(auth)
            }

        }

    }
}
