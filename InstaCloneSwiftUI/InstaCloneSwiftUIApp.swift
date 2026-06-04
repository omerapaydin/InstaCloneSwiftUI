//
//  InstaCloneSwiftUIApp.swift
//  InstaCloneSwiftUI
//
//  Created by Ömer Apaydın on 4.06.2026.
//

import SwiftUI
import FirebaseCore

@main
struct InstaCloneSwiftUIApp: App {
    init() {

            if FirebaseApp.app() == nil {

                FirebaseApp.configure()

            }

        }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
