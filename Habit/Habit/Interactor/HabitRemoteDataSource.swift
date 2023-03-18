//
//  HabitRemoteDataSource.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 10/02/23.
//

import Foundation
import Combine

class HabitRemoteDataSource {
    static var shared: HabitRemoteDataSource = HabitRemoteDataSource()
    
    func fetchHabits() -> Future<[habitResponse], AppError> {
        return Future<[habitResponse], AppError> { promise in
            WebService.call(path: .habits, method: .get, completion: { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                        
                        promise(.failure(AppError.response(message: response?.detail.message ?? "Error interno no servidor")))
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode([habitResponse].self, from: data)
                    
                    guard let res = response else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    
                    promise(.success(res))
                }
            })
        }
    }
}

