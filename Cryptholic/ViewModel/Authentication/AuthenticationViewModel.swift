//
//  AuthenticationViewModel.swift
//  Cryptholic
//
//  Created by Berkay Disli on 7.08.2022.
//

import Foundation
import Firebase
import GoogleSignIn


class AuthenticationViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var favouriteCoins = [String]()
    @Published var filtered = [Coin]()
    @Published var alertMessage = ""
    @Published var showAlert = false
    @Published var tempUserName = ""
    @Published var firebaseSignUpUsed = false
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func createAccount(name: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error {
                print(error.localizedDescription)
                self.alertMessage = error.localizedDescription
                self.showAlert = true
            } else {
                guard let user = result?.user else { return }
                self.userSession = user
                // Update Display Name
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges { error in
                    print(error?.localizedDescription ?? "ERROR: No error info.")
                }
                let userData = ["username": name, "email": email, "favourites": [String](), "nativeUser": true] as [String:Any]
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
            if let error {
                print(error.localizedDescription)
                self.alertMessage = error.localizedDescription
                self.showAlert = true
            } else {
                guard let user = result?.user else { return }
                self.userSession = user
                print("User logged in: \(user.email ?? "email error")")
            }
            self.getUserInfo { _ in            }
        }
    }
    
    func signInWithCredential() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: ApplicationUtility.rootViewController) { [unowned self] user, error in

          if let error {
            print(error)
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else { return }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)

        Auth.auth().signIn(with: credential) { result, error in
                if let error {
                    print(error.localizedDescription)
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                    return
                }
            guard let user = result?.user else { return }
            self.userSession = user
            
            Firestore.firestore().collection("users").document(user.uid).getDocument { _, error in
                if error == nil {
                    print("User already exists.")
                } else {
                    let userData = ["username": user.displayName ?? "No Username", "email": user.email ?? "No E-Mail"] as [String:Any]
                    Firestore.firestore().collection("users").document(user.uid).setData(userData) { error in
                        if let error { print(error.localizedDescription)} else {
                            print("User info saved.")
                        }
                    }
                }
            }
            
            self.getUserInfo { _ in  }
            
            }
        }
        
    }
    
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            userSession = nil
            favouriteCoins.removeAll(keepingCapacity: false)
            filtered.removeAll(keepingCapacity: false)
            print("User logged out. Info cleared.")
        } catch let err {
            print(err.localizedDescription)
            self.alertMessage = err.localizedDescription
            self.showAlert = true
        }
    }
    
    func getUserInfo(completion: (Bool) -> Void) {
        guard let userSession else { return }
        Firestore.firestore().collection("users").document(userSession.uid).getDocument { snapshot, error in
            guard let snapshot, error == nil else { return }
            
            guard let userFavs = snapshot.get("favourites") as? [String] else { return }
            
            self.favouriteCoins = userFavs
        }
        completion(true)
    }
    
    func addToFavourites(coin: Coin) {
        guard let userSession else { return }
        favouriteCoins.append(coin.id)
        Firestore.firestore().collection("users").document(userSession.uid).updateData(["favourites" : favouriteCoins]) { error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("Data is updated.")
            }
        }
    }
    
    func removeFromFavourites(coin: Coin) {
        guard let userSession else { return }
        favouriteCoins = favouriteCoins.filter { $0 != coin.id }
        Firestore.firestore().collection("users").document(userSession.uid).updateData(["favourites" : favouriteCoins]) { error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("Data is updated.")
            }
        }
    }
    
    func setTempUsernme(username: String) {
        tempUserName = username
    }
    
}
