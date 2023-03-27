//
//  GooglePlacesAPI.swift
//  InterviewSampleProject
//
//  Created by Sourav on 9/3/23.
//

import Foundation

enum OpenAIAPI: API {

    case getNearbyPlaces(searchText: String?, latitude: Double,
                         longitude: Double)

    case getCompletion(text: String)


    var scheme: HTTPScheme {
        switch self {
        case .getNearbyPlaces, .getCompletion:
            return .https
        }
    }
    
    var baseURL: String {
        switch self {
        case .getNearbyPlaces:
            return "maps.googleapis.com"
        case .getCompletion:
            return "api.openai.com"
        }
    }
    
    var path: String {
        switch self {
        case .getNearbyPlaces:
            return "/maps/api/place/nearbysearch/json"

        case .getCompletion:
            return "/v1/completions"
        }
    }

    var headerFields: [String : String] {
        [
            "Content-Type": "application/json",
            "Authorization": "Bearer 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"
        ]
    }
    
    var parameters: [String: Any] {
        switch self {
        case .getNearbyPlaces:
            return [:]

        case .getCompletion(let text):
            return [
                "model": "text-davinci-003",
                "prompt": text,
                "max_tokens": 250,
                "temperature": 0.7
            ]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getNearbyPlaces:
            return .get
            
        case .getCompletion:
            return .post
        }
    }
}
