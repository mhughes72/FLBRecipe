////
////  LLM.swift
////  FLBRecipes
////
////  Created by Matt Hughes on 2025-07-18.
////
//
import Foundation
import UIKit


//var ingredientListManager = IngredientListManager()

    
    
    
func base64ImageString(from image: UIImage) -> String? {
    guard let imageData = image.jpegData(compressionQuality: 0.8) else { return nil }
    return imageData.base64EncodedString()
}

func analyzeImageWithChatGPT(_ image: UIImage, ingredientListManager: IngredientListManager) {
    guard let base64 = base64ImageString(from: image) else { return }
    print("ANALYSING!!!!!!!!!!!!!!!!!")
    
    guard let apiKey = Bundle.main.infoDictionary?["chatGPT_API_KEY"] as? String else {
        print("GPT KEY: ERROR")
        return
    }
    
    
    let url = URL(string: "https://api.openai.com/v1/chat/completions")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let payload: [String: Any] = [
        "model": "gpt-4o",
        "messages": [
            [
                "role": "user",
                "content": [
                    [
                        "type": "image_url",
                        "image_url": [
                            "url": "data:image/jpeg;base64,\(base64)"
                        ]
                    ],
                    [
                        "type": "text",
                        "text": "From this photo of the inside of a fridge, identify only the edible food items that could be used as ingredients in a recipe.  Remove any packaging or quantity descriptions (e.g., 'bottle of ketchup' → 'ketchup', 'bunch of bananas' → 'bananas').  Return a comma-separated list of only the ingredient names — no extra words, no descriptions, no formatting, no sentences."
                    ]
                ]
            ]
        ],
        "max_tokens": 300
    ]
    
    request.httpBody = try? JSONSerialization.data(withJSONObject: payload)

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data {
            do {
                let decoded = try JSONDecoder().decode(ChatGPTResponse.self, from: data)
                let reply = decoded.choices.first?.message.content ?? "No response"
                DispatchQueue.main.async {
                    print("GPT says: \(reply)")
                    print("delegate 2: \(ingredientListManager.delegate!)")
                    ingredientListManager.fetchRecipe(ingredients: reply)
                    // update UI here
                }
            } catch {
                print("Decoding error: \(error)")
            }
        } else if let error = error {
            print("Request error: \(error)")
        }
    }
    task.resume()
}
