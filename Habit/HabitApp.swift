//
//  HabitApp.swift
//  Habit
//
//  Created by Tiago Aguiar on 08/04/21.
//

import SwiftUI

@main
struct HabitApp: App {
    var body: some Scene {
        WindowGroup {
          SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
        }
    }
}
