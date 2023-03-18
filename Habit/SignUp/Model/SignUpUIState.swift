//
//  SignUpUIState.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 30/01/23.
//

import Foundation

enum SignUpUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
