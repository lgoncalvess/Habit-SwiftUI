//
//  SplashViewModel.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 29/01/23.
//

import SwiftUI
import Combine

class SplasViewModel: ObservableObject {
    @Published var uiState: SplashUIState = .loading
    private var cancellableAuth: AnyCancellable?
    private var cancellableRefresh: AnyCancellable?

    
    private let interactor: SplashViewInteractor
    
    init(interactor: SplashViewInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableAuth?.cancel()
        cancellableRefresh?.cancel()
    }
    
    func onApper() {
        
        cancellableAuth = interactor.fetchAuth()
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                if userAuth == nil {
                    self.uiState = .goToSignInScreen
                } else if Date().timeIntervalSince1970 > Double(userAuth!.expires) {
                    self.cancellableRefresh = self.interactor.refreshToken(refreshRequest: RefreshRequest(token: userAuth!.refreshToken))
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .failure(_):
                                self.uiState = .goToSignInScreen
                                break
                            default:
                                break
                            }
                        }, receiveValue: { success in
                            self.interactor.insertAuth(userAuth: UserAuth(idToken: success.accessToken, refreshToken: success.refreshToken, expires: Date().timeIntervalSince1970 + Double(success.expires), tokenType: success.tokenType))
                            self.uiState = .goToHomeScreen
                        })
                } else {
                    self.uiState = .goToHomeScreen
                }
            }
    }
}

extension SplasViewModel {
    func sigInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
    
    func homeView() -> some View {
        return SplashViewRouter.makeHomeView()
    }
}
