//
//  Gender.swift
//  Habit
//
//  Created by Tiago Aguiar on 06/05/21.
//

import Foundation


enum Gender: String, CaseIterable, Identifiable {
  case male = "Masculino"
  case female = "Feminino"
  
  var id: String {
    self.rawValue
  }
  
  var index: Self.AllCases.Index {
    return Self.allCases.firstIndex { self == $0 } ?? 0
  }
  
}
