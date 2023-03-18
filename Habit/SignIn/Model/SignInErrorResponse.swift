//
//  SignInErrorResponse.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 04/02/23.
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
