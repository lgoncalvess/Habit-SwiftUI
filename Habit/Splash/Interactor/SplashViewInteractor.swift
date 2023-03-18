//
//  SplashViewInteractor.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 06/02/23.
//

import Foundation
import Combine

class SplashViewInteractor {
    private let remote: SplashRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}

extension SplashViewInteractor {
    func fetchAuth() -> Future<UserAuth?, Never> {
        return local.getUserAuth()
    }
    
    func refreshToken(refreshRequest request: RefreshRequest) -> Future<SignInResponse, AppError>{
        return remote.refreshToken(request: request)
    }
    
    func insertAuth(userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
}
