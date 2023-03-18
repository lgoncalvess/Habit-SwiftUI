//
//  RemoteDataSource.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 05/02/23.
//

import Foundation
import Combine

class SignInRemoteDataSource {
    static var shared: SignInRemoteDataSource = SignInRemoteDataSource()
    
    private init() {
        
    }

    func login(request: SignInRequest) -> Future<SignInResponse, AppError> {
        return Future<SignInResponse, AppError> { promise in
            WebService.call(path: .login, params: [URLQueryItem(name: "username", value: request.email), URLQueryItem(name: "password", value: request.password)]) { result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .unauthorized {
                            print(String(data: data, encoding: .utf8) ?? "")
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                            print(response?.detail ?? "")
                            promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido")))
                        }
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(SignInResponse.self, from: data)
                    guard let response = response else {
                        print("Error de parser.")
                        return
                    }
                    promise(.success(response))
                    break
                }
            }
        }
    }
}
