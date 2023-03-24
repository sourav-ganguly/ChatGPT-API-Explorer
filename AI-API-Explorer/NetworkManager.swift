//
//  NetworkManager.swift
//  AI-API-Explorer
//
//  Created by Sourav on 25/3/23.
//

//import Foundation
//
//import Foundation
//
//enum NetworkEndpoint {
//    case getUser(id: Int)
//    case createUser(name: String, email: String)
//    // Add more endpoints as needed
//
//    var baseURL: String {
//        return "https://example.com/api/"
//    }
//
//    var path: String {
//        switch self {
//        case .getUser(let id):
//            return "users/\(id)"
//        case .createUser:
//            return "users"
//        }
//    }
//
//    var httpMethod: String {
//        switch self {
//        case .getUser:
//            return "GET"
//        case .createUser:
//            return "POST"
//        }
//    }
//
//    var body: Data? {
//        switch self {
//        case .getUser:
//            return nil
//        case .createUser(let name, let email):
//            let params = ["name": name, "email": email]
//            return try? JSONSerialization.data(withJSONObject: params, options: [])
//        }
//    }
//
//    var headers: [String: String] {
//        return ["Content-Type": "application/json"]
//    }
//}
//
//class NetworkManager {
//    static let shared = NetworkManager()
//    private let session: URLSession
//
//    private init() {
//        let configuration = URLSessionConfiguration.default
//        session = URLSession(configuration: configuration)
//    }
//
//    func makeRequest(endpoint: NetworkEndpoint, completion: @escaping (Data?, Error?) -> Void) {
//        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
//            let error = NSError(domain: "NetworkManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
//            completion(nil, error)
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = endpoint.httpMethod
//        request.allHTTPHeaderFields = endpoint.headers
//        request.httpBody = endpoint.body
//
//        let task = session.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(nil, error)
//            } else if let data = data {
//                completion(data, nil)
//            }
//        }
//        task.resume()
//    }
//}

import Foundation

protocol NetworkEndpoint {
    associatedtype Response: Decodable

    var baseURL: String { get }
    var path: String { get }
    var httpMethod: String { get }
    var body: Data? { get }
    var headers: [String: String] { get }
}

extension NetworkEndpoint {
    var baseURL: String {
        return "https://example.com/api/"
    }

    func makeRequest(completion: @escaping (Result<Response, Error>) -> Void) {
        guard let url = URL(string: baseURL + path) else {
            let error = NSError(domain: "NetworkEndpoint", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headers
        request.httpBody = body

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(response))
                } catch let decodingError {
                    completion(.failure(decodingError))
                }
            }
        }
        task.resume()
    }
}

class NetworkManager<Endpoint: NetworkEndpoint> {
    func request(endpoint: Endpoint, completion: @escaping (Result<Endpoint.Response, Error>) -> Void) {
        endpoint.makeRequest(completion: completion)
    }
}

enum UserEndpoint: NetworkEndpoint {
    typealias Response = User

    case getUser(id: Int)
    case createUser(name: String, email: String)

    var path: String {
        switch self {
        case .getUser(let id):
            return "users/\(id)"
        case .createUser:
            return "users"
        }
    }

    var httpMethod: String {
        switch self {
        case .getUser:
            return "GET"
        case .createUser:
            return "POST"
        }
    }

    var body: Data? {
        switch self {
        case .getUser:
            return nil
        case .createUser(let name, let email):
            let params = ["name": name, "email": email]
            return try? JSONSerialization.data(withJSONObject: params, options: [])
        }
    }

    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
}

struct User: Decodable {
    let id: Int
    let name: String
    let email: String
}
