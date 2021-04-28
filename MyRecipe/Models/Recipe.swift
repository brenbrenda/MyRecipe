//
//  Recipe.swift
//  MyRecipe
//
//  Created by chia on 2021/4/19.
//

import Foundation

//struct Recipe: Codable {
//    let results: [Result]
//}
//struct Result: Codable {
//    let id: Int
//    let title: String
//    let image: URL
//    let nutrition: Nutrition
//   
//}
//struct Nutrition: Codable {
//    let nutrients: [Nutrients]
//}
//struct Nutrients: Codable {
//    let title: String
//    let amount: Double
//    let unit: String
//}

struct RecipeCate: Codable {
    let recipes: [RecipeDetail]
}
struct RecipeDetail: Codable {
    let vegan: Bool
    let extendedIngredients: [ExtendedIngredients]
    let id : Int
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let image: URL?
    let analyzedInstructions: [AnalyzedInstructions]

}
struct ExtendedIngredients: Codable {
    let originalString: String
    let originalName: String
    let amount: Double
    let unit: String?
   
}
struct AnalyzedInstructions: Codable {
    let steps: [Step]
}
struct Step: Codable {
    let number: Int
    let step: String
}



    //let APIkey: String = "4ff9f759176f40fe807cfa4febdffa89"



/*
struct ParseRecipeController {
    static let shared = ParseRecipeController()
    private let Str = "https://api.spoonacular.com/recipes/complexSearch?apiKey=4ff9f759176f40fe807cfa4febdffa89&query=pasta&maxFat=25"
    func ParseRecipe() {
        guard let url = URL(string: Str) else {
            print("invalidURL")
            return
        }
        URLSession.shared.dataTask(with: url) {data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed request:\(error!.localizedDescription)")
                    return
                }
                guard let data = data else {
                    print("No data returned")
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let recipe = try decoder.decode(Recipe.self, from: data)
                    
                } catch {
                    print("Unable to decode response: \(error.localizedDescription)")
                }
            }
            
        }.resume()
    }
}*/
