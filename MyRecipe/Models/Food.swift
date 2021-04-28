//
//  Food.swift
//  MyRecipe
//
//  Created by chia on 2021/4/28.
//

import Foundation

struct Food: Codable {
    var description: String
//    static func saveFood
}
//struct Lover: Codable {
//    var name: String
//    var star: String
//    var innerBeauty: Bool
//    var weight: Double
//    static func save(_ lovers: [Lover]) {
//        let encoder = JSONEncoder()
//        guard let data  = try? encoder(lovers) else { return  }
//        let userDefault = UserDefaults.standard
//        userDefault.set(data, forKey: "lovers")
//    }
//    static func loadLovera() -> [Lover]? {
//        let userDefault = UserDefaults.standard
//        guard let data = userDefault.data(forKey: "lovers") else { return nil }
//        let decoder = JSONDecoder()
//        return try?decoder.decode([Lover.self], from: data)
//    }
//}
 
