//
//  HabitDetailInteractor.swift
//  Habit
//
//  Created by Tiago Aguiar on 24/06/21.
//

import Foundation
import Combine

class HabitDetailInteractor {
  
  private let remote: HabitDetailRemoteDataSource = .shared
  
}

extension HabitDetailInteractor {
  
  func save(habitId: Int, habitValueRequest request: HabitValueRequest) -> Future<Bool, AppError> {
    return remote.save(habitId: habitId, request: request)
  }  
  
}
