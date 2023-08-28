//
//  FavoritesManager.swift
//  SwiftApp
//
//  Created by Viktor van Hulle on 28/08/2023.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    
    private let favoritesKey = "FavoritesKey"
    
    var favoriteQuotes: [Quote] {
        get {
            if let data = UserDefaults.standard.data(forKey: favoritesKey),
               let favorites = try? JSONDecoder().decode([Quote].self, from: data) {
                return favorites
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: favoritesKey)
            }
        }
    }
    
    func addQuoteToFavorites(_ quote: Quote) {
        
        if !favoriteQuotes.contains(where: {$0.quote == quote.quote}) {
            var favorites = favoriteQuotes
            favorites.append(quote)
            favoriteQuotes = favorites
        }
    }
    
    
    func removeQuoteFromFavorites(_ quote: Quote) {
        var favorites = favoriteQuotes
        if let index = favorites.firstIndex(where: { $0.quote == quote.quote }) {
            favorites.remove(at: index)
            favoriteQuotes = favorites
        }
    }
}
