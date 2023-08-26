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
    var categories = [
        "age", "alone", "amazing", "anger", "architecture", "art", "attitude", "beauty",
        "best", "birthday", "business", "car", "change", "communications", "computers", "cool",
        "courage", "dad", "dating", "death", "design", "dreams", "education", "environmental",
        "equality", "experience", "failure", "faith", "family", "famous", "fear", "fitness",
        "food", "forgiveness", "freedom", "friendship", "funny", "future", "god", "good",
        "government", "graduation", "great", "happiness", "health", "history", "home", "hope",
        "humor", "imagination", "inspirational", "intelligence", "jealousy", "knowledge",
        "leadership", "learning", "legal", "life", "love", "marriage", "medical", "men",
        "mom", "money", "morning", "movies", "success"
    ]
    
    var pickerView = UIPickerView()
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var categoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configSelector()
        updateQuote()
        
    }
    
    func configSelector(){
        pickerView.delegate = self
        pickerView.dataSource = self
        categoryTextField.inputView = pickerView
        
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

//From "Easiest UIPickerView with UITextfield Xcode 11 Swift 5" tutorial
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in  pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component : Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = categories[row]
        categoryTextField.resignFirstResponder()
    }
    
}
