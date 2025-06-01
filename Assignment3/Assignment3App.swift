//
// Assignment3App.swift : Assignment3
//
// Copyright © 2023 Auburn University.
// All Rights Reserved.


import SwiftUI
import FirebaseCore
import FirebaseAuth


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Assignment3App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var isAuthenticated = false
    
    var body: some Scene {
        WindowGroup {
            RootView(isAuthenticated: $isAuthenticated)
        }
    }
}

struct RootView: View {
    @Binding var isAuthenticated: Bool

    var body: some View {
        Group {
            if isAuthenticated {
                AirlineView(isAuthenticated: $isAuthenticated)
            } else {
                SigninSignUp(isAuthenticated: $isAuthenticated)
            }
        }
        .onAppear {
            if Auth.auth().currentUser != nil {
                isAuthenticated = true
            }
        }
    }
}
