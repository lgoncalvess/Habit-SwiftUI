//
//  ProfileInteractor.swift
//  Habit
//
//  Created by Tiago Aguiar on 08/07/21.
//

import Foundation
import Combine

class ProfileInteractor {
  
  private let remote: ProfileRemoteDataSource = .shared
  
}

extension ProfileInteractor {
  
  func fetchUser() -> Future<ProfileResponse, AppError> {
    return remote.fetchUser()
  }
  
  func updateUser(userId: Int, profileRequest: ProfileRequest) -> Future<ProfileResponse, AppError> {
    return remote.updateUser(userId: userId, request: profileRequest)
  }
  
}
