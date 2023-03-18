//
//  WebService.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 02/02/23.
//

import Foundation

enum WebService {
    
    enum Endpoint: String {
        case base = "https://habitplus-api.tiagoaguiar.co"
        case postUser = "/users"
        case login = "/auth/login"
        case fetchUser = "/users/me"
        case updateUser = "/users/%d"
        case refreshToken = "/auth/refresh-token"
        case habits = "/users/me/habits"
        case habitValues = "/users/me/habits/%d/values"
    }
    
    enum Result {
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    enum Method: String {
        case get
        case post
        case put
        case delete
    }
    
    enum NetworkError {
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
    }
    
    enum ContentType: String {
        case json = "application/json"
        case formUrl = "application/x-www-form-urlencoded"
    }
    
    private static func completeUrl(path: String) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path)") else {return nil}
        return URLRequest(url: url)
    }
    
    public static func call(path: String, method: Method, contentType: ContentType, data: Data?, completion: @escaping (Result) -> Void) {
        guard var urlRequest = completeUrl(path: path) else {return}
        _ = LocalDataSource.shared.getUserAuth()
            .sink { userAuth in
                if let userAuth = userAuth {
                    urlRequest.setValue("\(userAuth.tokenType) \(userAuth.idToken)", forHTTPHeaderField: "Authorization")
                }
                
                urlRequest.httpMethod = method.rawValue
                urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
                urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = data
                
                let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    guard let data, error == nil else {
                        print(error ?? "")
                        completion(.failure(.internalServerError, nil))
                        return
                    }
                    
                    if let r = response as? HTTPURLResponse {
                        switch r.statusCode {
                        case 400:
                            completion(.failure(.badRequest, data))
                            break
                        case 401:
                            completion(.failure(.unauthorized, data))
                            break
                        case 200:
                            completion(.success(data))
                        default:
                            break
                        }
                    }
                    
                    print("response\n")
                    print(response ?? "")
                }
                
                task.resume()
            }
    }
    
    public static func call(path: Endpoint, method: Method = .get, completion: @escaping (Result) -> Void) {

        call(path: path.rawValue, method: method, contentType: .json, data: nil, completion: completion)
    }
    
    public static func call<T: Encodable>(path: String, method: Method = .get, body: T, completion: @escaping (Result) -> Void) {

        let jsonData = try? JSONEncoder().encode(body)
        call(path: path, method: method, contentType: .json, data: jsonData, completion: completion)
    }
    
    public static func call<T: Encodable>(path: Endpoint, method: Method = .get, body: T, completion: @escaping (Result) -> Void) {

        let jsonData = try? JSONEncoder().encode(body)
        call(path: path.rawValue, method: method, contentType: .json, data: jsonData, completion: completion)
    }
    
    public static func call(path: Endpoint, method: Method = .post, params: [URLQueryItem], completion: @escaping (Result) -> Void) {
        guard let urlRequest = completeUrl(path: path.rawValue) else {return}
        guard let absoluteURL = urlRequest.url?.absoluteString else { return }
        var components = URLComponents(string: absoluteURL)
        components?.queryItems = params
        
        call(path: path.rawValue, method: method, contentType: .formUrl, data: components?.query?.data(using: .utf8), completion: completion)
    }
}