//
//  DailyQuoteViewController.swift
//  SwiftApp
//
//  Created by Viktor van Hulle on 28/08/2023.
//

import UIKit

class DailyQuoteViewController: BackgroundViewController {
    
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "First go to 'Settings' and set a time for your daily quote."
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your quote generator app"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .right
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupQuote()
        setupUI()
    }
    
    private func setupQuote(){
        
        if let savedQuote = QuoteDataManager.shared.savedQuote {
            quoteLabel.text = savedQuote.quote
            authorLabel.text = savedQuote.author
        }

    }
    

    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(quoteLabel)
        view.addSubview(authorLabel)
        
        NSLayoutConstraint.activate([
            quoteLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            quoteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            quoteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            authorLabel.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
