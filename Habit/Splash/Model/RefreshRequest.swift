//
//  RefreshRequest.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 07/02/23.
//

import Foundation

struct RefreshRequest: Encodable {
    
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "refresh_token"
    }
}
