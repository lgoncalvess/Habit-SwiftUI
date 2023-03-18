//
//  SignUpViewModel.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 30/01/23.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = ""
    @Published var phone = ""
    @Published var birthday = ""
    @Published var gender = Gender.male
    
    var publisher: PassthroughSubject<Bool, Never>!
    private var cancellableSignIn: AnyCancellable?
    private var cancellableSignUp: AnyCancellable?

    
    @Published var uiState: SignUpUIState = .none
    
    private let interactor: SignUpInteractor
    
    init(interactor: SignUpInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableSignIn?.cancel()
        cancellableSignUp?.cancel()
    }
    
    func signUp() {
        self.uiState = .loading
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        let dateFormatted = formatter.date(from: birthday)
        
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("data inválida \(birthday)")
            return
        }
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        let birthday = formatter.string(from: dateFormatted)
        
        let SignUpRequest = SignUpRequest(fullName: fullName, email: email, password: password, document: document, phone: phone, birthday: birthday, gender: gender.index)
        
        cancellableSignUp = interactor.postUser(request: SignUpRequest)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            } receiveValue: { created in
                if created {
                    self.cancellableSignIn = self.interactor.login(request: SignInRequest(email: self.email, password: self.password))
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            switch completion {
                            case .failure(let appError):
                                self.uiState = .error(appError.message)
                                break
                            case .finished:
                                break
                            }
                        } receiveValue: { success in
                            print(success)
                            
                            self.interactor.inserAuth(userAuth: UserAuth(idToken: success.accessToken, refreshToken: success.refreshToken, expires: Date().timeIntervalSince1970 + Double(success.expires), tokenType: success.tokenType))
                            
                            self.publisher.send(created)
                            self.uiState = .success
                        }
                }
            }
    }
}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
