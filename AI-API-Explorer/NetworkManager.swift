//
//  NetworkManager.swift
//  AI-API-Explorer
//
//  Created by Sourav on 25/3/23.
//

import Foundation

protocol NetworkEndpoint {
    associatedtype Response: Decodable

    var baseURL: String { get }
    var path: String { get }
    var httpMethod: String { get }
    var body: [URLQueryItem] { get }
    var headers: [String: String] { get }
}

extension NetworkEndpoint {
    var baseURL: String {
        return "https://example.com/api/"
    }

    func makeRequest(completion: @escaping (Result<Response, Error>) -> Void) {
        guard var components = URLComponents(string: baseURL + path) else {
            let error = NSError(domain: "NetworkEndpoint", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }
        if !body.isEmpty {
            components.queryItems = body
        }

        var request = URLRequest(url: components.url!)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headers

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

    var body: [URLQueryItem] {
        switch self {
        case .getUser:
            return []
        case .createUser(let name, let email):
            return [URLQueryItem(name: "name", value: name), URLQueryItem(name: "email", value: email)]
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
