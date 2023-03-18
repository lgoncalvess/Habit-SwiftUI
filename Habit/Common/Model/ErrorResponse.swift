//
//  ErrorResponse.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 03/02/23.
//

import Foundation


struct ErrorResponse: Decodable {
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
