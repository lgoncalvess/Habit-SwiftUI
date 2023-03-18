//
//  Date+Extension.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 10/02/23.
//

import Foundation

extension Date {
    func toString(destPattern dest: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = dest
        
        return formatter.string(from: self)
    }
}
