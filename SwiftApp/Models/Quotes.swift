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

#if DEBUG
extension Quote {
    static  var sampleData = [
        Quote(
            quote: "No amount of money ever  bought  a second of time",
            author:  "Tony Stark",
            category: "time"
        ),
        Quote(
            quote: "All we have to do is decide what to do with  the time that is given to us",
            author:  "Gandalf",
            category: "time"
        ),
        
    ]
}
#endif

class Api : ObservableObject{
    @Published var quotes = [Quote]()
    func loadData(for category: String, completion: @escaping ([Quote]) -> ()) {
        
        let encodedCategory = category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category=" + encodedCategory!)!
        var request = URLRequest(url: url)
        request.setValue("ufhrScuFZN1Vlu+Pjo6GgA==cMXnFwIHyGap40Qq", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            let quotes = try! JSONDecoder().decode([Quote].self, from: data!)
            DispatchQueue.main.async {
                completion(quotes)
            }
        }
        task.resume()
        
    }
    
}
