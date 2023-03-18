//
//  HomeViewRouter.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 08/02/23.
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
