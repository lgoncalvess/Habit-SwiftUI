//
//  SignInErrorResponse.swift
//  Habit
//
//  Created by Tiago Aguiar on 19/05/21.
//

import Foundation

struct SignInErrorResponse: Decodable {
  
  let detail: SignInDetailErrorResponse
  
  enum CodingKeys: String, CodingKey {
    case detail
  }
  
}

struct SignInDetailErrorResponse: Decodable {
  
  let message: String
  
  enum CodingKeys: String, CodingKey {
    case message
  }
  
}
