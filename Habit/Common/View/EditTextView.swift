//
//  EditTextView.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 01/02/23.
//

import SwiftUI

struct EditTextView: View {
    
    @Binding var text: String
    var placeholder: String = ""
    var error: String? = nil
    var failure: Bool? = nil
    var keyboard: UIKeyboardType?
    var isSecure: Bool?
    
    var body: some View {
        VStack {
            if isSecure ?? false {
                SecureField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard ?? .default)
                    .textFieldStyle(CustomTextFieldStyle())
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard ?? .default)
                    .textFieldStyle(CustomTextFieldStyle())
            }

            if let error = error, failure == true,  !text.isEmpty {
                Text(error).foregroundColor(.red)
            }
        }
        .padding(.bottom, 10)
    }
}

struct EditTextView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            VStack {
                EditTextView(text: .constant("ss"), placeholder: "bitch", error: "Alo", failure: "abcd".count > 4)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .previewDevice("Iphone 14 Pro")
            .preferredColorScheme($0)
        }
    }
}
