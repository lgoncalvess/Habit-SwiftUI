//
//  HabitDetailUIState.swift
//  Habit
//
//  Created by Tiago Aguiar on 21/06/21.
//

import Foundation


enum HabitDetailUIState: Equatable {
  case none
  case loading
  case success
  case error(String)
}
