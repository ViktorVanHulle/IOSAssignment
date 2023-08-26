//
//  ViewController.swift
//  SwiftApp
//
//  Created by Viktor van Hulle on 25/08/2023.
//

import UIKit

class ViewController: UIViewController {
    

    let api = Api()
    var currentCategory: String = "happiness" // Default category
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var categoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateQuote()
        
    }

    @IBAction func changeCategoryButton(_ sender: UIButton) {
        if let newCategory = categoryTextField.text {
            currentCategory = newCategory
            updateQuote()
        }
    }
    
    
    func updateQuote() {
        api.loadData(for: currentCategory) { [weak self] quotes in
            guard let self = self, let randomQuote = quotes.randomElement() else {
                return
            }

            DispatchQueue.main.async {
                self.quoteLabel.text = randomQuote.quote
                self.authorLabel.text = randomQuote.author
            }
        }
    }

}

