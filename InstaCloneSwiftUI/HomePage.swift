//
//  HomePage.swift
//  InstaCloneSwiftUI
//
//  Created by Ömer Apaydın on 5.06.2026.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {

                LazyVStack(spacing: 20) {

                        VStack(alignment: .leading, spacing: 12) {

                            
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

                                
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 280)
                                    .frame(maxWidth: .infinity)
                                    .clipped()
                                    .background(Color.gray.opacity(0.15))
                                    .cornerRadius(14)

                                
                                HStack(spacing: 18) {

                                    Button {
                                        // like
                                    } label: {
                                        Image(systemName: "heart")
                                            .font(.system(size: 20))
                                    }

                                    Button {
                                        // comment
                                    } label: {
                                        Image(systemName: "message")
                                            .font(.system(size: 20))
                                    }

                                    Button {
                                        // share
                                    } label: {
                                        Image(systemName: "paperplane")
                                            .font(.system(size: 20))
                                    }

                                    Spacer()

                                    Button {
                                        // save
                                    } label: {
                                        Image(systemName: "bookmark")
                                            .font(.system(size: 20))
                                    }
                                }
                                .foregroundColor(.black)

                                // CAPTION
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("root")
                                        .fontWeight(.semibold)
                                        .font(.subheadline)

                                    Text("SwiftUI")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }

                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(18)
                            .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
                        }
                        .padding(.horizontal)
                    
                }
                .padding(.top, 10)
            }
            .navigationTitle("Instagram")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomePage()
}
