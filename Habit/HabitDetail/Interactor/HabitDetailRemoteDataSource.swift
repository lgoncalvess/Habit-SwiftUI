//
//  HabitDetailRemoteDataSource.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 11/02/23.
//

import Foundation
import Combine

class HabitDetailRemoteDataSource {
    static var shared: HabitDetailRemoteDataSource = HabitDetailRemoteDataSource()
    
    private init() {
        
    }

    func save(habitId: Int, request: HabitValueRequest) -> Future<Bool, AppError> {
        return Future<Bool, AppError> { promise in
            let path = String(format: WebService.Endpoint.habitValues.rawValue, habitId)
            
            WebService.call(path: path, method: .post, body: request) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        print(String(data: data, encoding: .utf8) ?? "")
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                        print(response?.detail ?? "")
                        promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido")))
                    }
                    break
                case .success(_):
                    promise(.success(true))
                    break
                }
            }
        }
    }
}
