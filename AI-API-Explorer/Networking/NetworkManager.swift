//
//  NetworkManager.swift
//  InterviewSampleProject
//
//  Created by Sourav on 9/3/23.
//

import Foundation


final class NetworkManager {

    /// Builds the relevant URL components from the values specified
    /// in the API.
    private class func buildURL(endpoint: API) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.baseURL
        components.path = endpoint.path
//        components.queryItems = endpoint.parameters
        return components
    }

    /// Executes the HTTP request and will attempt to decode the JSON
    /// response into a Codable object.
    /// - Parameters:
    ///   - endpoint: the endpoint to make the HTTP request to
    ///   - completion: the JSON response converted to the provided Codable
    /// object when successful or a failure otherwise
    class func request<T: Decodable>(endpoint: API,
                                     completion: @escaping (Result<T, Error>)
                                     -> Void) {
        let components = buildURL(endpoint: endpoint)

        guard let url = components.url else {
            Log.error("URL creation error")
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue

        for (key, value) in endpoint.headerFields {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: endpoint.parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            completion(.failure(error))
        }


        let session = URLSession(configuration: .default)

        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                Log.error("Unknown error", error)
                return
            }
            guard response != nil, let data = data else {
                return
            }
            if let responseObject = try? JSONDecoder().decode(T.self,
                                                              from: data) {
                completion(.success(responseObject))
            } else {
                let error = NSError(domain: "com.AryamanSharda",
                                    code: 200,
                                    userInfo: [
                                        NSLocalizedDescriptionKey: "Failed"
                                    ])
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }

}

class Log {
    class func error(_ info: String, _ error: Error) {

    }
    class func error(_ info: String) {

    }
}
