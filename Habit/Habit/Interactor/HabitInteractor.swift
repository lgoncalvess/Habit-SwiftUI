//
//  HabitInteractor.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 10/02/23.
//

import Foundation
import Combine

class HabitInteractor {
    private let remote: HabitRemoteDataSource = .shared
}

extension HabitInteractor {
    func fetchHabits() -> Future<[habitResponse], AppError> {
        return remote.fetchHabits()
    }
}
