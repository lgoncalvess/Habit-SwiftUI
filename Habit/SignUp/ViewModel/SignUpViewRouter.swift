//
//  SignUpViewRouter.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 30/01/23.
//

import SwiftUI

enum SignUpViewRouter {
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
