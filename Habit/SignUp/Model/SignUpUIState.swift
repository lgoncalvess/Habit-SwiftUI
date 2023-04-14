//
//  SignUpUIState.swift
//  Habit
//
//  Created by Tiago Aguiar on 07/05/21.
//

import Foundation

enum SignUpUIState: Equatable {
  case none
  case loading
  case success
  case error(String)
}
