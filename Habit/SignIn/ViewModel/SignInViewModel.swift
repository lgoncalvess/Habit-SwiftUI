//
//  SignInViewModel.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 29/01/23.
//

import SwiftUI
import Combine
class SignInViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?
    private let publisher = PassthroughSubject<Bool, Never>()
    private let interactor: SignInInteractor
    
    @Published var uiState: SignUIState = .none
    
    init(interactor: SignInInteractor) {
        self.interactor = interactor
        cancellable = publisher.sink { value in
            print(value)
            
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit {
        cancellable?.cancel()
        cancellableRequest?.cancel()
    }
    
    func login() {
        self.uiState = .loading
        cancellableRequest = interactor.login(request: SignInRequest(email: email, password: password))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = SignUIState.error(appError.message)
                   break
                case .finished:
                    break
                }
            } receiveValue: { success in
                print(success)
                self.interactor.inserAuth(userAuth: UserAuth(idToken: success.accessToken, refreshToken: success.refreshToken, expires: Date().timeIntervalSince1970 + Double(success.expires), tokenType: success.tokenType))
                self.uiState = .goToHomeScreen
            }
        }
}

extension SignInViewModel {
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
}
