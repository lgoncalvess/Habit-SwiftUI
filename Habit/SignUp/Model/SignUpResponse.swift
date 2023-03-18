//
//  SignUpResponse.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 03/02/23.
//

import Foundation

struct SignUpResponse: Decodable {
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
