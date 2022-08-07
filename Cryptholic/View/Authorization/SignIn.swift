//
//  Onboarding.swift
//  Cryptholic
//
//  Created by Berkay Disli on 6.08.2022.
//

import SwiftUI

struct SignIn: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
                //logo
                VStack(spacing: 0) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .colorMultiply(.red)
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
                        
                    } label: {
                        BigButton(title: "Sign In", bgColor: .black)
                            .padding()
                    }
                    
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
        }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
