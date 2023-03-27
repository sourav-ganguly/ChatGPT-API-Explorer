//
//  API.swift
//  InterviewSampleProject
//
//  Created by Sourav on 7/3/23.
//

import Foundation

protocol API {
    var scheme: HTTPScheme { get }
    var baseURL: String { get }
    var path: String { get }
    var headerFields: [String: String] { get }
    var parameters: [String: Any] { get }
    var method: HTTPMethod { get }

}
