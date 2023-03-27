//
//  TextCompletion.swift
//  AI-API-Explorer
//
//  Created by Sourav on 27/3/23.
//

import Foundation

struct TextCompletion: Codable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]
    let usage: Usage

    struct Choice: Codable {
        let text: String
        let index: Int
        let logprobs: String?
        let finishReason: String

        private enum CodingKeys: String, CodingKey {
            case text, index, logprobs, finishReason = "finish_reason"
        }
    }

    struct Usage: Codable {
        let promptTokens: Int
        let completionTokens: Int
        let totalTokens: Int

        private enum CodingKeys: String, CodingKey {
            case promptTokens = "prompt_tokens"
            case completionTokens = "completion_tokens"
            case totalTokens = "total_tokens"
        }
    }
}
