//
//  CustomInputView.swift
//  Cryptholic
//
//  Created by Berkay Disli on 7.08.2022.
//

import SwiftUI

struct CustomInputView: View {
    let imageName: String
    let placeholder: String
    let autoCapitalisation: Bool
    @Binding var text: String
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
                TextField(placeholder, text: $text)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(autoCapitalisation ? .words : .never)
            }
            
            Divider()
                .background(.gray)
        }
    }
}

struct CustomInputView_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputView(imageName: "person", placeholder: "email", autoCapitalisation: false, text: .constant(""))
    }
}
