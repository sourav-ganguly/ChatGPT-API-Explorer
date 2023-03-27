//
//  TextCompletionRepository.swift
//  AI-API-Explorer
//
//  Created by Sourav on 27/3/23.
//

import Foundation

class TextCompletionRepository {

    func getTextCompletion(text: String, completion: @escaping (Result<TextCompletion, Error>) -> Void) {
        NetworkManager.request(endpoint: OpenAIAPI.getCompletion(text: text), completion: completion)
    }

}
