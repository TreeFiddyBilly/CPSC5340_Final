//
//  SigninSignUp.swift
//  Assignment3
//
//  Created by user272344 on 6/1/25.
//

import SwiftUI
import FirebaseAuth

struct SigninSignUp: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLogin = true
    @State private var errorMessage = ""
    @Binding var isAuthenticated: Bool
    
    var body: some View {
        Group {
            if isAuthenticated {
                AirlineView(isAuthenticated: $isAuthenticated)
            } else {
                VStack(spacing: 20) {
                    Text(isLogin ? "Sign In" : "Sign Up")
                        .font(.largeTitle)
                        .bold()
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    Button(action: {
                        if isLogin {
                            signIn()
                        } else {
                            signUp()
                        }
                    }) {
                        Text(isLogin ? "Sign In" : "Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    Button(action: {
                        isLogin.toggle()
                        errorMessage = ""
                    }) {
                        Text(isLogin ? "No account? Sign Up" : "Already have an account? Sign In")
                            .foregroundColor(.gray)
                            .font(.footnote)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            if Auth.auth().currentUser != nil {
                isAuthenticated = true
            }
        }
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) {result, error in
            if let error = error {
                errorMessage = "Sign in failed: \(error.localizedDescription)"
            } else {
                isAuthenticated = true
            }
        }
    }
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = "Sign up failed: \(error.localizedDescription)"
            } else {
                isAuthenticated = true
            }
        }
    }
}


