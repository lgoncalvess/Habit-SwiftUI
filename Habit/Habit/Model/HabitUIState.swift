//
//  HabitUIState.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 08/02/23.
//

import Foundation

enum HabitUIState: Equatable {
    case loading
    case emptyList
    case fullList([HabitCardViewModel])
    case error(String)
}
