//
//  SignUpView.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 29/01/23.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Cadastro")
                            .foregroundColor(Color("textColor"))
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        fullNameField
                        
                        emailField
                        
                        documentField
                        
                        phoneField
                        
                        birthdayField
                        
                        passwordField
                        
                        genderField
                        
                        saveButton
                        
                    }
                    Spacer()
                }
                .padding(.horizontal, 8)
            }
            .padding()
            
            if case SignUpUIState.error(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text(" "), message: Text(value), dismissButton: .default(Text("Ok")){
                            
                        })
                    }
            }
        }
    }
}

extension SignUpView {
    var fullNameField: some View {
        EditTextView(text: $viewModel.fullName, placeholder: "Digite seu nome completo", error: "nome inválido", failure: viewModel.fullName.count < 3)

    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(text: $viewModel.email, placeholder: "Digite seu email", error: "email inválido", failure: !viewModel.email.isEmail(), keyboard: .emailAddress)

    }
}

extension SignUpView {
    var passwordField: some View {
        EditTextView(text: $viewModel.password, placeholder: "Digite sua senha", error: "senha precisa de no minimo 8 caracteres.", failure: viewModel.password.count < 8, isSecure: true)
    }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(text: $viewModel.document, placeholder: "Digite seu CPF", error: "CPF inválido", failure: viewModel.document.count != 11, keyboard: .numberPad)

    }
}

extension SignUpView {
    var phoneField: some View {
        EditTextView(text: $viewModel.phone, placeholder: "Digite seu celular", error: "Entre com DDD + 8 ou 9 digitos", failure: viewModel.phone.count < 10 || viewModel.phone.count >= 12, keyboard: .numberPad)

    }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(text: $viewModel.birthday, placeholder: "Digite sua data de nascimento", error: "Data deve ser dd/MM/yyyy", failure: viewModel.birthday.count != 10, keyboard: .default)
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $viewModel.gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue)
                    .tag(value)
            }
        }
        .pickerStyle(.segmented)
        .padding(.top, 16)
        .padding(.bottom, 32)
    }
}

extension SignUpView {
    var saveButton: some View {
        LoadingButtonView(action: {
            viewModel.signUp()
        }, disabled: !viewModel.email.isEmail() || viewModel.password.count < 8 || viewModel.fullName.count < 3 || viewModel.document.count != 11 || viewModel.phone.count < 10 || viewModel.phone.count >= 12 || viewModel.birthday.count != 10, showProgress: self.viewModel.uiState == SignUpUIState.loading, text: "Cadastrar")
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel(interactor: SignUpInteractor()))
            .preferredColorScheme(.dark)
    }
}
