//
//  File.swift
//  
//
//  Created by Raffaele Siciliano on 17/01/23.
//

import Foundation
import SwiftUI

enum Category : String, CaseIterable {
    case shot = "Shots"
    case beer = "Beers"
    case wine = "Wines"
    case shortDrink = "Short Drinks"
    case mediumDrink = "Medium Drinks"
    case longDrink = "Long Drinks"
    
    var name : String {
        switch self {
        case .shot :
            return "Shot"
        case .beer:
            return "Beer"
        case .wine:
            return "Wine"
        case .shortDrink:
            return "Short Drink"
        case .mediumDrink:
            return "Medium Drink"
        case .longDrink:
            return "Long Drink"
        }
    }
    var iconName : String {
        switch self {
        case .shot:
            return "DrinkingGlass"
        case .beer:
            return "BeerGlass"
        case .wine:
            return "WineGlass"
        case .shortDrink:
            return "CocktailGlass"
        case .mediumDrink:
            return ""
        case .longDrink:
            return ""
        }
    }
    
    var listIconName : String {
        switch self {
        case .shot :
            return "OrangeShot"
        case .beer:
            return "OrangeBeer"
        case .wine:
            return "OrangeWine"
        case .shortDrink:
            return "OrangeCocktail"
        case .mediumDrink:
            return "OrangeCocktail"
        case .longDrink:
            return "OrangeCocktail"
        }
    }
    
}

struct Drink : Identifiable, Hashable, Encodable {
    let id = UUID()
    var category : Category
    var name : String
    var alcoholByVolume : Double
    var milliliters : Double
    var isFavorite : Bool = false
}


extension Category: Codable {
    enum CodingKeys: String, CodingKey {
        case rawValue
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawValue = try container.decode(String.self, forKey: .rawValue)
        self = Category(rawValue: rawValue)!
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.rawValue, forKey: .rawValue)
    }
}

func createJson(listDrink: [Drink]) {
    do {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(listDrink)
        let jsonString = String(data: jsonData, encoding: .utf8)
        print(jsonString)
        // codifica i dati in formato JSON
//        let jsonEncoder = JSONEncoder()
//        let jsonData = try jsonEncoder.encode(listDrink)
//        // scrivi i dati codificati in un file chiamato "drinks.json"
//        let fileURL = URL(fileURLWithPath: "drinks.json", relativeTo: FileManager.default.temporaryDirectory)
//        try jsonData.write(to: fileURL)
        print("Fatto")
    } catch {
        print("Error while creating json file: \(error)")
    }
}

class DrinkViewModel : ObservableObject {
    
    // MARK: List of Drinks
    @Published var allDrinks : [Drink] =
    [//MEDIUM DRINKS LIST
     Drink(category: .mediumDrink,name: "Mimosa",alcoholByVolume: 12.0,milliliters: 150.0),
     Drink(category: .mediumDrink,name: "Aperol Spritz",alcoholByVolume: 11.0,milliliters: 150.0),
     Drink(category: .mediumDrink, name: "Moscow Mule", alcoholByVolume: 12.0, milliliters: 175.0),
     Drink(category: .mediumDrink, name: "Pina Colada", alcoholByVolume: 17.0, milliliters: 130.0),
     Drink(category: .mediumDrink, name: "Gin Tonic", alcoholByVolume: 17.0, milliliters: 140.0),
     Drink(category: .mediumDrink, name: "Mojito", alcoholByVolume: 18.0, milliliters: 180.0),
     Drink(category: .mediumDrink, name: "Classic Sangria", alcoholByVolume: 16.0, milliliters: 180.0),
     //SHORT DRINKS LIST
     Drink(category: .shortDrink, name: "Negroni", alcoholByVolume: 29.0, milliliters: 90.0),
     Drink(category: .shortDrink, name: "Angelo Azzurro", alcoholByVolume: 35.0, milliliters: 110.0),
     Drink(category: .shortDrink, name: "Manhattan", alcoholByVolume: 30.0, milliliters: 70.0),
     Drink(category: .shortDrink, name: "Dry Martini", alcoholByVolume: 29.8, milliliters: 70.0),
     Drink(category: .shortDrink, name: "Godfather", alcoholByVolume: 30.0, milliliters: 70.0),
     Drink(category: .shortDrink, name: "Caipirinha", alcoholByVolume: 36.0, milliliters: 60.0),
     Drink(category: .shortDrink, name: "Margarita", alcoholByVolume: 25.4, milliliters: 85.0),
     Drink(category: .shortDrink, name: "Whiskey Sour", alcoholByVolume: 13.3, milliliters: 90.0),
     //LONG DRINKS LIST
     Drink(category: .longDrink, name: "Cuba Libre", alcoholByVolume: 12.0, milliliters: 180.0),
     Drink(category: .longDrink, name: "Daiquiri", alcoholByVolume: 17.0, milliliters: 80.0),
     //GENERIC BEERS LIST
     Drink(category: .beer, name: "Small Beer", alcoholByVolume: 7.5, milliliters: 25.0),
     Drink(category: .beer, name: "Big Beer", alcoholByVolume: 7.5, milliliters: 50.0),
     //WINES LIST
     Drink(category: .wine, name: "Red Wine", alcoholByVolume: 13.5, milliliters: 200.0),
     Drink(category: .wine, name: "White Wine", alcoholByVolume: 13.5, milliliters: 150.0),
     Drink(category: .wine, name: "Rosé Wine", alcoholByVolume: 12.0, milliliters: 200.0),
     //SHOTS LIST
     Drink(category: .shot, name: "Tequila", alcoholByVolume: 40.0, milliliters: 30.0),
     Drink(category: .shot, name: "Jägermeister", alcoholByVolume: 35.0, milliliters: 30.0),
     Drink(category: .shot, name: "Fireball Cinnamon Whiskey", alcoholByVolume: 33.3, milliliters: 30.0),
     Drink(category: .shot, name: "Sambuca", alcoholByVolume: 38.0, milliliters: 30.0),
     Drink(category: .shot, name: "Asbinthe", alcoholByVolume: 65.0, milliliters: 30.0),
     Drink(category: .shot, name: "Goldschlager", alcoholByVolume: 40.0, milliliters: 30.0),
     Drink(category: .shot, name: "Bacardi 151", alcoholByVolume: 75.5, milliliters: 15.0),
     Drink(category: .shot, name: "Rakia", alcoholByVolume: 50.0, milliliters: 30.0),
     Drink(category: .shot, name: "Smooth Vodka", alcoholByVolume: 40.0, milliliters: 30.0),
     Drink(category: .shot, name: "Whiskey", alcoholByVolume: 40.0, milliliters: 30.0),
     Drink(category: .shot, name: "Rum", alcoholByVolume: 40.0, milliliters: 30.0),
     Drink(category: .shot, name: "B-52", alcoholByVolume: 27.5, milliliters: 30.0),
     Drink(category: .shot, name: "Latte di Suocera", alcoholByVolume: 70.0, milliliters: 30.0)
    ]
}
