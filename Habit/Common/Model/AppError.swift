//
//  AppError.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 05/02/23.
//

import Foundation

enum AppError: Error {
    case response(message: String)
    
    public var message: String {
        switch self {
        case .response(let message):
            return message
        }
    }
}
