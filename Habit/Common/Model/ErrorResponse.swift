//
//  ErrorResponse.swift
//  Habit
//
//  Created by Tiago Aguiar on 18/05/21.
//

import Foundation

struct ErrorResponse: Decodable {
  let detail: String
  
  enum CodingKeys: String, CodingKey {
    case detail
  }
}
