//
//  SignUpInteractor.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 05/02/23.
//

import Foundation
import Combine

class SignUpInteractor {
    private let remoteSignUp: SignUpRemoteDataSource = .shared
    private let remoteSignIn: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}

extension SignUpInteractor {
    func postUser(request: SignUpRequest) -> Future<Bool, AppError> {
        return remoteSignUp.postUser(request: request)
    }
    
    func login(request: SignInRequest) -> Future<SignInResponse, AppError> {
        return remoteSignIn.login(request: request)
    }
    
    func inserAuth(userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }

}
