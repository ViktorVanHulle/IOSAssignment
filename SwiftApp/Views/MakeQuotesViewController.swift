//
//  MakeQuotesViewController.swift
//  SwiftApp
//
//  Created by Viktor van Hulle on 26/08/2023.
//

import UIKit

class MakeQuotesViewController: UIViewController {

    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add New Quote"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Category:"
        return label
    }()
    
    private let categoryTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter category"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Quote:"
        return label
    }()
    
    private let quoteTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter quote"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add quote", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        //bg color
        button.backgroundColor = UIColor(hex: "#FF6B6B")
        button.layer.cornerRadius = 12
    
        button.addTarget(self, action: #selector(addQuoteButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(categoryLabel)
        view.addSubview(categoryTextField)
        view.addSubview(quoteLabel)
        view.addSubview(quoteTextField)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            categoryTextField.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            categoryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            quoteLabel.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor, constant: 16),
            quoteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            quoteTextField.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 8),
            quoteTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            quoteTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addButton.widthAnchor.constraint(equalToConstant: 200),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func addQuoteButtonTapped() {
        // Check if both category and quote text fields are non-empty
        guard let category = categoryTextField.text,
              let quoteText = quoteTextField.text,
              !category.isEmpty, !quoteText.isEmpty else {
            // Show an alert or message indicating that both fields are required
            return
        }
        
        // Create a new Quote object
        let newQuote = Quote(quote: quoteText, author: "Your Name", category: category)
        
        // Add the new quote to your list of quotes
        QuoteDataManager.shared.addQuote(newQuote)
        
        let myQuotesVC = MyQuotesViewController()
        // Notify the delegate that a new quote was added
        myQuotesVC.delegate?.didAddNewQuote()
        
        navigationController?.pushViewController(myQuotesVC, animated: true)
        
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
