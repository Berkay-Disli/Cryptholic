//
//  AuthenticationViewModel.swift
//  Cryptholic
//
//  Created by Berkay Disli on 7.08.2022.
//

import Foundation
import Firebase

class AuthenticationViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func createAccount(name: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error {
                print(error.localizedDescription)
            } else {
                guard let user = result?.user else { return }
                self.userSession = user
                print("User created: \(user.email ?? "email error")")
                
                let userData = ["username": name, "email": email] as [String:Any]
                Firestore.firestore().collection("users").document(user.uid).setData(userData) { error in
                    if let error { print(error.localizedDescription)} else {
                        print("User info saved.")
                    }
                }
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error { print(error.localizedDescription) } else {
                guard let user = result?.user else { return }
                self.userSession = user
                print("User logged in: \(user.email ?? "email error")")
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            userSession = nil
            print("User logged out.")
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    
}
