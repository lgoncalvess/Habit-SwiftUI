//
//  AppError.swift
//  Habit
//
//  Created by Tiago Aguiar on 25/05/21.
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

