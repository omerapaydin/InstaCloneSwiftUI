//
//  HomePage.swift
//  InstaCloneSwiftUI
//
//  Created by Ömer Apaydın on 5.06.2026.
//

import SwiftUI
import PhotosUI


struct HomePage: View {

    @State private var showUploadView = false
    @State private var selectedImage: UIImage?

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {

                LazyVStack(spacing: 20) {

                    VStack(alignment: .leading, spacing: 12) {

                        HStack(spacing: 10) {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 38, height: 38)

                            VStack(alignment: .leading, spacing: 2) {
                                Text("root")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)

                                Text("2h ago")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            Image(systemName: "ellipsis")
                                .foregroundColor(.gray)
                        }

                        
                        if let selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 280)
                                .frame(maxWidth: .infinity)
                                .clipped()
                                .cornerRadius(14)
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFill()
                                .frame(height: 280)
                                .frame(maxWidth: .infinity)
                                .clipped()
                                .background(Color.gray.opacity(0.15))
                                .cornerRadius(14)
                        }

                        HStack(spacing: 18) {

                            Button { } label: {
                                Image(systemName: "heart")
                                    .font(.system(size: 20))
                                Text("125")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                            }

                            Button { } label: {
                                Image(systemName: "message")
                                    .font(.system(size: 20))
                            }

                            Button { } label: {
                                Image(systemName: "paperplane")
                                    .font(.system(size: 20))
                            }

                            Spacer()
                        }
                        .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(18)
                    .shadow(color: .black.opacity(0.06), radius: 8)
                    .padding(.horizontal)
                }
                .padding(.top, 10)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Instagram")
            .navigationBarTitleDisplayMode(.inline)

            .toolbar {

                ToolbarItem(placement: .topBarLeading) {
                    Button {
                    } label: {
                        Image(systemName: "camera")
                            .font(.title3)
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showUploadView.toggle()
                    } label: {
                        Image(systemName: "plus.app")
                            .font(.title3)
                    }
                }
            }

         
            .sheet(isPresented: $showUploadView) {
                UploadPostView(selectedImage: $selectedImage)
            }
        }
    }
}





struct UploadPostView: View {

    @Environment(\.dismiss) var dismiss

    @Binding var selectedImage: UIImage?

    @State private var selectedItem: PhotosPickerItem?
    @State private var caption: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images
                ) {
                    if let selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .clipped()
                            .cornerRadius(12)
                    } else {
                        Image(systemName: "photo.badge.plus")
                            .font(.system(size: 80))
                            .foregroundColor(.black)
                    }
                }

                Text("Yeni Gönderi")
                    .font(.title2)
                    .fontWeight(.bold)

                TextField("Bir açıklama yaz...", text: $caption)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                Button {
                    print("Caption: \(caption)")
                    print("Image: \(String(describing: selectedImage))")

                } label: {
                    Text("Paylaş")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Gönderi Oluştur")
            .navigationBarTitleDisplayMode(.inline)

            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Kapat") {
                        dismiss()
                    }
                    .foregroundColor(.black)
                }
            }

            .onChange(of: selectedItem) {
                Task {
                    guard let item = selectedItem else { return }

                    if let data = try? await item.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        selectedImage = uiImage
                    }
                }
            }
        }
        .tint(.black)
    }
}

#Preview {
    HomePage()
}
