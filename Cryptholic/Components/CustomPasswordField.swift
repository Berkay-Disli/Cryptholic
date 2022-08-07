//
//  CustomPasswordField.swift
//  Cryptholic
//
//  Created by Berkay Disli on 7.08.2022.
//

import SwiftUI

struct CustomPasswordField: View {
    let imageName: String
    let placeholder: String
    @Binding var text: String
    var body: some View {
        VStack {
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
                SecureField(placeholder, text: $text)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
            }
            Divider()
                .background(.gray)
        }
    }
}

struct CustomPasswordField_Previews: PreviewProvider {
    static var previews: some View {
        CustomPasswordField(imageName: "lock", placeholder: "password", text: .constant(""))
    }
}
