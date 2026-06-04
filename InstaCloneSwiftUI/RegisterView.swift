//
//  RegisterView.swift
//  InstaCloneSwiftUI
//
//  Created by Ömer Apaydın on 4.06.2026.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    var goLogin: () -> Void

    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    let db = Firestore.firestore()
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

                    Text("Üye Ol")
                        .font(.largeTitle.bold())

                    Text("Yeni hesap oluştur")
                        .foregroundColor(.gray)
                }

                VStack(spacing: 15) {

                    input(icon: "person", placeholder: "Kullanıcı Adı", text: $username)
                    input(icon: "envelope", placeholder: "E-Mail", text: $email)
                    input(icon: "lock", placeholder: "Şifre", text: $password, isSecure: true)
                    input(icon: "lock.rotation", placeholder: "Şifre Tekrar", text: $confirmPassword, isSecure: true)

                    Button {

                        guard password == confirmPassword else {
                            print("Şifreler uyuşmuyor")
                            return
                            }
                        guard !email.isEmpty, !password.isEmpty, !username.isEmpty else {
                            print("Boş alan bırakma")
                            return
                        }
                        
                        Auth.auth().createUser(withEmail: email, password: password) { result, error in
                            if let error = error {
                                print(error.localizedDescription)
                                return
                            }
                           
                            var ref : DocumentReference! = nil
                            guard let uid = result?.user.uid else { return }
                            let myDictionary : [String : Any] = ["username" : username, "email" : email,"userid":uid]
                            
                            ref = self.db.collection("Users").addDocument(data :myDictionary ,completion: { error in
                                if error != nil {
                                    print(error?.localizedDescription)
                                }else {
                                    print("Firestore kayıt başarılı")
                                    DispatchQueue.main.async {
                                           dismiss()
                                       }
                                }
                            })
                            
                            

                        }

                    } label: {

                        Text("Üye Ol")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(14)
                    }
                    

                    Button {
                        goLogin()
                    } label: {
                        Text("Zaten hesabın var mı? Giriş Yap")
                            .foregroundColor(.gray)
                            .font(.footnote)
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
        }
    }
    func input(icon: String,
               placeholder: String,
               text: Binding<String>,
               isSecure: Bool = false) -> some View {
        
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)

            if isSecure {
                SecureField(placeholder, text: text)
            } else {
                TextField(placeholder, text: text)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.06), radius: 10)
    }
}

#Preview {
    RegisterView(goLogin: {})
}
