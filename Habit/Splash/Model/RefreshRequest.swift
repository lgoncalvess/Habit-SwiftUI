//
//  RefreshRequest.swift
//  Habit
//
//  Created by Tiago Aguiar on 02/06/21.
//

import Foundation

struct RefreshRequest: Encodable {
  
  let token: String
  
  enum CodingKeys: String, CodingKey {
    case token = "refresh_token"
  }
  
}
