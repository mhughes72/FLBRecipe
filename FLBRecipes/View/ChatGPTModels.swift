//
//  ChatGPTModels.swift
//  FLBRecipes
//
//  Created by Matt Hughes on 2025-07-19.
//

import Foundation

struct ChatGPTResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: Message
}

struct Message: Codable {
    let role: String
    let content: String
}

