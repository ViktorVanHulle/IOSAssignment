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
    private let myQuotesKey = "SavedQuoteFromMyself"

    var myQuotes: [Quote] {
         get {
             if let data = UserDefaults.standard.data(forKey: myQuotesKey),
                let quotes = try? JSONDecoder().decode([Quote].self, from: data) {
                 return quotes
             }
             return []
         }
         set {
             if let data = try? JSONEncoder().encode(newValue) {
                 UserDefaults.standard.set(data, forKey: myQuotesKey)
             }
         }
     }
    
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
    
    func addQuote(_ quote: Quote) {
        var quotes = myQuotes
        quotes.append(quote)
        myQuotes = quotes
     }
    
    
    func removeQuote(_ quote: Quote) {
        var quotes = myQuotes
        if let index = quotes.firstIndex(where: { $0.quote == quote.quote }) {
            quotes.remove(at: index)
            myQuotes = quotes
        }
    }
}
