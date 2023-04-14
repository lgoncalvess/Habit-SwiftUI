//
//  SignUpViewRouter.swift
//  Habit
//
//  Created by Tiago Aguiar on 07/05/21.
//

import SwiftUI

enum SignUpViewRouter {
  
  static func makeHomeView() -> some View {
    let viewModel = HomeViewModel()
    return HomeView(viewModel: viewModel)
  }
  
}
