//
//  HabitInteractor.swift
//  Habit
//
//  Created by Tiago Aguiar on 18/06/21.
//

import Foundation
import Combine

class HabitInteractor {
  
  private let remote: HabitRemoteDataSource = .shared
  
}

extension HabitInteractor {
  
  func fetchHabits() -> Future<[HabitResponse], AppError> {
    return remote.fetchHabits()
  }
  
}
