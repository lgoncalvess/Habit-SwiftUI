//
//  SignInView.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 29/01/23.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel
    
    var body: some View {
        ZStack {
            if case SignUIState.goToHomeScreen = viewModel.uiState {
                viewModel.homeView()
            } else {
                NavigationView {
                    ScrollView {
                        VStack(alignment: .center, spacing: 20){
                            Spacer(minLength: 36)
                            VStack(alignment: .center, spacing: 8) {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal, 48)
                                
                                Text("Login")
                                    .foregroundColor(.orange)
                                    .font(Font.system(.title)
                                        .bold())
                                    .padding(.bottom, 8)
                                emailField
                                passwordField
                                enterButton
                                registerLink
                                
                                Text("Copyright 2023")
                                    .foregroundColor(Color.gray)
                                    .font(Font.system(size: 16).bold())
                                    .padding(.top, 16)
                            }
                        }
                        
                        if case SignUIState.error(let value) = viewModel.uiState {
                            Text("")
                                .alert(isPresented: .constant(true)) {
                                    Alert(title: Text(" "), message: Text(value), dismissButton: .default(Text("Ok")){
                                        
                                    })
                                }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 32)
                    .navigationBarTitle("login", displayMode: .inline)
                    .toolbar(.hidden)
                }

            }
        }
    }
}

extension SignInView {
    var emailField: some View {
        EditTextView(text: $viewModel.email, placeholder: "Digite seu email", error: "email inválido", failure: !viewModel.email.isEmail(), keyboard: .emailAddress)
    }
}

extension SignInView {
    var passwordField: some View {
        EditTextView(text: $viewModel.password, placeholder: "Digite sua senha", error: "senha precisa de no minimo 8 caracteres.", failure: viewModel.password.count < 8, isSecure: true)
    }
}

extension SignInView {
    var enterButton: some View {
        LoadingButtonView(action: {
            viewModel.login()
        }, disabled: !viewModel.email.isEmail() || viewModel.password.count < 8, showProgress: self.viewModel.uiState == SignUIState.loading, text: "Entrar")
    }
}

extension SignInView {
    var registerLink: some View {
        VStack {
            Text("Você ainda não possui um login?")
                .foregroundColor(.gray)
                .padding(.top, 48)
            
            ZStack {
                NavigationLink(destination: viewModel.signUpView(), label: {
                    Text("Realize seu cadastro")
                })
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = SignInViewModel(interactor: SignInInteractor())
        SignInView(viewModel: vm)
            .previewDevice("Iphone 14 Pro")
            .preferredColorScheme(.light)
    }
}
