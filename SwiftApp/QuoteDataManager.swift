//
//  DataManager.swift
//  SwiftApp
//
//  Created by Viktor van Hulle on 28/08/2023.
//

import Foundation

class QuoteDataManager {
    static let shared = QuoteDataManager()
    
    private let quoteKey = "SavedQuote"
    
    var savedQuote: Quote? {
        get {
            if let savedQuoteData = UserDefaults.standard.data(forKey: quoteKey) {
                let decoder = JSONDecoder()
                if let savedQuote = try? decoder.decode(Quote.self, from: savedQuoteData) {
                    return savedQuote
                }
            }
            return nil
        }
        set {
            let encoder = JSONEncoder()
            if let encodedQuote = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encodedQuote, forKey: quoteKey)
            }
        }
    }
}
