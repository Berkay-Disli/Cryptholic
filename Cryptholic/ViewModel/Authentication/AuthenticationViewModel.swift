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
                
                let userData = ["username": name, "email": email, "favourites": ["bitcoin", "ethereum", "tether"]] as [String:Any]
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
                    return
                }
            guard let user = result?.user else { return }
            self.userSession = user
            print("User logged in with GOOGLE: \(user)")
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
    
}
