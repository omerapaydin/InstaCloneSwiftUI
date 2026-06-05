import SwiftUI
import FirebaseAuth
import Combine

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false

    init() {
        checkAuth()
    }

    func checkAuth() {
        isLoggedIn = Auth.auth().currentUser != nil
    }

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if error == nil {
                DispatchQueue.main.async {
                    self.isLoggedIn = true
                }
            }
        }
    }

    func logout() {
        try? Auth.auth().signOut()
        isLoggedIn = false
    }
}
