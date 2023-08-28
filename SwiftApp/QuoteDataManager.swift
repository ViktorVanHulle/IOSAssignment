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
    
    var myQuotes: [Quote] = [Quote(quote: "test", author: "me'", category: "your mom")]
    
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
         myQuotes.append(quote)
         saveQuotes()
     }
    
    func saveQuotes(){
        //with UserDefaults storage mechanism
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(myQuotes) {
            UserDefaults.standard.set(encodedData, forKey: "MyQuotesKey")
        }
    }
}
