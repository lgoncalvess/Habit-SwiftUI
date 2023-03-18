//
//  String+Extension.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 01/02/23.
//

import Foundation

extension String {
    func isEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }

    func toDate(sourcePattern source: String, destPattern dest: String) -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        let dateFormatted = formatter.date(from: self)
        
        guard let dateFormatted = dateFormatted else {
            return nil
        }
        
        formatter.dateFormat = dest
        return formatter.string(from: dateFormatted)
    }
    
    func toDate(sourcePattern source: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        return formatter.date(from: self)
    }
}
