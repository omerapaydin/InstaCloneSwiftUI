//
//  ContentView.swift
//  InstaCloneSwiftUI
//
//  Created by Ömer Apaydın on 4.06.2026.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    
    @EnvironmentObject var auth: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
  
    
  
    var body: some View {
        
        if isLoggedIn {
               HomePage()
        } else {
            NavigationStack {

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
                               
                                Auth.auth().signIn(withEmail: self.email, password: self.password) { (result, error) in
                                    if error != nil {
                                        print(error!.localizedDescription)
                                    } else {
                                        print("User logged in")
                                        DispatchQueue.main.async {
                                            isLoggedIn = true
                                        }
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

                           
                            NavigationLink {
                                RegisterView(goLogin: {})
                            } label: {
                                Text("Hesabın yok mu? Üye Ol").foregroundColor(.black)
                            }

                        }
                        .padding(.horizontal)

                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
