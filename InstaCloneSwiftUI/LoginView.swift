import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @EnvironmentObject var auth: AuthViewModel
    @Environment(\.dismiss) var dismiss   // ✅ EKLENDİ

    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(
                colors: [.white, Color.gray.opacity(0.08)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                
                Spacer()
                
                VStack(spacing: 10) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 65))
                        .foregroundStyle(.black)

                    Text("Giriş Yap")
                        .font(.largeTitle.bold())

                    Text("Hesabına giriş yap")
                        .foregroundColor(.gray)
                }
                
                VStack(spacing: 15) {

                    // EMAIL
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)

                        TextField("E-Mail", text: $email)
                            .textInputAutocapitalization(.never)
                            .autocapitalization(.none)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.05), radius: 5)

                    // PASSWORD
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.gray)

                        SecureField("Şifre", text: $password)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.05), radius: 5)

                    // LOGIN BUTTON
                    Button {
                        
                        guard !email.isEmpty, !password.isEmpty else {
                            print("Boş alan bırakma")
                            return
                        }

                        Auth.auth().signIn(withEmail: email, password: password) { result, error in
                            
                            if let error = error {
                                print(error.localizedDescription)
                                return
                            }

                            print("User logged in")

                            DispatchQueue.main.async {
                                auth.isLoggedIn = true
                                dismiss()   
                            }
                        }
                        
                    } label: {
                        Text("Giriş Yap")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(14)
                    }

                    // REGISTER
                    NavigationLink {
                        RegisterView(goLogin: {})
                    } label: {
                        Text("Hesabın yok mu? Üye Ol")
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
