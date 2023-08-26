//
//  Quotes.swift
//  SwiftApp
//
//  Created by Viktor van Hulle on 25/08/2023.
//

import Foundation

struct Quote: Codable, Identifiable {
    let id = UUID()
    var quote: String
    var author: String
    var category: String
    
}

class Api : ObservableObject{
    @Published var quotes = [Quote]()
    func loadData(for category: String, completion: @escaping ([Quote]) -> ()) {
        
        let encodedCategory = category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category=" + encodedCategory!)!
        var request = URLRequest(url: url)
        request.setValue("ufhrScuFZN1Vlu+Pjo6GgA==cMXnFwIHyGap40Qq", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            let quotes = try! JSONDecoder().decode([Quote].self, from: data!)
            print(quotes)
            DispatchQueue.main.async {
                completion(quotes)
            }
        }
        task.resume()
        
    }
}
