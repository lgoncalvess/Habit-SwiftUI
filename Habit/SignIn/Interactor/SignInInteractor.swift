//
//  SignInInteractor.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 05/02/23.
//

import Foundation
import Combine

class SignInInteractor {
    private let remote: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}

extension SignInInteractor {
    
    func login(request: SignInRequest) -> Future<SignInResponse, AppError> {
        return remote.login(request: request)
    }
    
    func inserAuth(userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
}
