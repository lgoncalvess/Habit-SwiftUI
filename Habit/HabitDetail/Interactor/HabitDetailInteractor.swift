//
//  HabitDetailInteractor.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 11/02/23.
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
