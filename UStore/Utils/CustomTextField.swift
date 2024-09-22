//
//  CustomTextField.swift
//  UStore
//
//  Created by Amir Lotfi on 07.09.24.
//


import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var title: String
    var iconBefor: String? = nil
    var iconAfter: String? = nil
    var showIcon: Bool = true
    var isSecure: Bool = false
    // State for toggling password visibility
    @State private var isPasswordVisible: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(GilroyFonts.font(style: .semiBold, size: 16))
                .foregroundColor(Colors.secondary.color())
            
            ZStack {
                HStack {
                    if isSecure && !isPasswordVisible {
                        SecureField(placeholder, text: $text)
                            .padding(.vertical, 15)
                            .padding(.horizontal, 10)
                           
                    } else {
                        TextField(placeholder, text: $text)
                            .padding(.vertical, 15)
                            .padding(.horizontal, 10)
                          
                    }

                    if showIcon {
                        Image(systemName: (isPasswordVisible ? iconBefor : iconAfter) ?? "")
                            .foregroundColor(Colors.secondary.color())
                            .padding(.trailing, 15)
                            .onTapGesture {
                                isPasswordVisible.toggle()
                            }
                    }
                }
                .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Colors.secondary.color(), lineWidth: 1))
                .frame(height: 50)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.top, 20)
    }
}




struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        @State var email = ""
        CustomTextField(
            text: $email,
            placeholder: "Enter your Email",
            title: "Email",
            iconBefor:  "envelope",
            iconAfter: "eye",
            showIcon: true
        )
        .padding()
    }
}





