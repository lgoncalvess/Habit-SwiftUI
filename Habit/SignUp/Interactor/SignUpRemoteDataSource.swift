//
//  SignUpRemoteDataSource.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 05/02/23.
//

import Foundation
import Combine

class SignUpRemoteDataSource {
    
    static var shared: SignUpRemoteDataSource = SignUpRemoteDataSource()

    private init() {
        
    }
    
    func postUser(request: SignUpRequest) -> Future<Bool, AppError> {
        return Future { promise in
            WebService.call(path: .postUser, method: .post, body: request) { result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .badRequest {
                            print(String(data: data, encoding: .utf8) ?? "")
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(ErrorResponse.self, from: data)
                            promise(.failure(AppError.response(message: response?.detail ?? "Erro desconhecido")))
                            print(response?.detail ?? "")
                        }
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
