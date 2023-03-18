//
//  HabitApp.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 27/01/23.
//

import SwiftUI

@main
struct HabitApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplasViewModel(interactor: SplashViewInteractor()))
        }
    }
}
