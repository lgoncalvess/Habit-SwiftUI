//
//  SignInUIState.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 29/01/23.
//

import Foundation

enum SignUIState: Equatable {
    case none
    case loading
    case goToHomeScreen
    case error(String)
}
