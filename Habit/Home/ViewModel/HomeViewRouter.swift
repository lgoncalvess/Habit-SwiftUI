//
//  HomeViewRouter.swift
//  Habit
//
//  Created by Tiago Aguiar on 09/06/21.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
  
  static func makeHabitView(viewModel: HabitViewModel) -> some View {
    return HabitView(viewModel: viewModel)
  }
  
  static func makeProfileView(viewModel: ProfileViewModel) -> some View {
    return ProfileView(viewModel: viewModel)
  }
  
}
