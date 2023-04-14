//
//  ProfileUIState.swift
//  Habit
//
//  Created by Tiago Aguiar on 08/07/21.
//

import Foundation

enum ProfileUIState: Equatable {
  case none
  case loading
  case fetchSuccess
  case fetchError(String)
  
  case updateLoading
  case updateSuccess
  case updateError(String)
}
