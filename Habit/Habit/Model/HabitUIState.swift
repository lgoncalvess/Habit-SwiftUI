//
//  HabitUIState.swift
//  Habit
//
//  Created by Tiago Aguiar on 09/06/21.
//

import Foundation

enum HabitUIState: Equatable {
  case loading
  case emptyList
  case fullList([HabitCardViewModel])
  case error(String)
}
