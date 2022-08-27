//
//  Onboarding.swift
//  Cryptholic
//
//  Created by Berkay Disli on 6.08.2022.
//

import SwiftUI

struct SignIn: View {
    @EnvironmentObject var authVM: AuthenticationViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
                //logo
                VStack(spacing: 0) {
                    Image(colorScheme == .dark ?  "logoFinalBlack":"logoFinal")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130)
                }
                .padding(.vertical)
                
                // header
                GreetHeader(title1: "Hi!", title2: "Welcome back.", secondColor: .red)
                
                // Inputs
                VStack {
                    CustomInputView(imageName: "envelope", placeholder: "e-mail", autoCapitalisation: false, text: $email)
                        .padding([.horizontal, .bottom])
                    CustomPasswordField(imageName: "lock", placeholder: "password", text: $password)
                        .padding([.horizontal, .top])
                }
                .padding()
                
                
                VStack {
                    
                    Button {
                        
                    } label: {
                        Text("Forgot Password?")
                            .font(.system(size: 13)).fontWeight(.semibold)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding([.top, .trailing])
                    }

                    
                    Button {
                        if !email.isEmpty && !password.isEmpty {
                            authVM.signIn(email: email, password: password)
                        }
                    } label: {
                        BigButton(title: "Sign In", bgColor: Color("bigButtonBlack"), textColor: Color("white"))
                            .padding()
                    }
                    .alert(authVM.alertMessage, isPresented: $authVM.showAlert) {}
                    
                    Button {
                        authVM.signInWithCredential()
                    } label: {
                        BigSymbolButton(title: "Sign In With Google", bgColor: colorScheme == .dark ? .gray.opacity(0.7):.gray.opacity(0.3), textColor: Color("black"), image: "google")
                            .padding(.horizontal)
                    }
                    .alert(authVM.alertMessage, isPresented: $authVM.showAlert) {}
                    
                    Spacer()
                    
                    NavigationLink {
                        SignUp()
                    } label: {
                        HStack(spacing: 4) {
                            Text("Don't have an account?")
                            Text("Sign Up.")
                                .fontWeight(.medium)
                        }
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                    }
                }
                .padding(.bottom)
            }
            .background(Color("bg"))
        }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
            .environmentObject(AuthenticationViewModel())
    }
}
