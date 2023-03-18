//
//  HabitDetailUIState.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 11/02/23.
//

import Foundation

enum HabitDetailUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
