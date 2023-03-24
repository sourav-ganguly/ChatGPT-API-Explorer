import Foundation

protocol NetworkEndpoint {
    associatedtype Response: Decodable

    var baseURL: String { get }
    var path: String { get }
    var httpMethod: String { get }
    var body: [URLQueryItem] { get }
    var headers: [String: String] { get }
}

class NetworkManager<Endpoint: NetworkEndpoint> {
    func makeRequest(endpoint: Endpoint, completion: @escaping (Result<Endpoint.Response, Error>) -> Void) {
        guard var components = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            let error = NSError(domain: "NetworkEndpoint", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }
        if !endpoint.body.isEmpty {
            components.queryItems = endpoint.body
        }

        var request = URLRequest(url: components.url!)
        request.httpMethod = endpoint.httpMethod
        request.allHTTPHeaderFields = endpoint.headers

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(Endpoint.Response.self, from: data)
                    completion(.success(response))
                } catch let decodingError {
                    completion(.failure(decodingError))
                }
            }
        }
        task.resume()
    }
}

enum UserEndpoint: NetworkEndpoint {
    typealias Response = User

    case getUser(id: Int)
    case createUser(name: String, email: String)

    var baseURL: String {
        return "https://example.com/api/v1/"
    }

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
