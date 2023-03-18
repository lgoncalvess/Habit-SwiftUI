//
//  ProfileUIState.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 14/02/23.
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
