//
//  File.swift
//  
//
//  Created by Raffaele Siciliano on 17/01/23.
//

import Foundation

final class Drink: Codable {
    var id: UUID
    var category: Category
    var name: String
    var alcoholByVolume: Double
    var milliliters: Double
    var isFavorite: Bool

    
    enum Category : String, CaseIterable, Codable {
        case shot = "Shots"
        case beer = "Beers"
        case wine = "Wines"
        case shortDrink = "Short Drinks"
        case mediumDrink = "Medium Drinks"
        case longDrink = "Long Drinks"
    }
//    enum CodingKeys: String, CodingKey {
//        case category
//    }

    init(id: UUID, category: Category, name: String, alcoholByVolume: Double, milliliters: Double, isFavorite: Bool) {
        self.id = id
        self.category = category
        self.name = name
        self.alcoholByVolume = alcoholByVolume
        self.milliliters = milliliters
        self.isFavorite = isFavorite
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = UUID()
        self.id = try container.decode(UUID.self, forKey: .id)
        let categoryString = try container.decode(String.self, forKey: .category)
        self.category = Category(rawValue: categoryString) ?? .shot
        self.name = try container.decode(String.self, forKey: .name)
        self.alcoholByVolume = try container.decode(Double.self, forKey: .alcoholByVolume)
        self.milliliters = try container.decode(Double.self, forKey: .milliliters)
        self.isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
    }

}
