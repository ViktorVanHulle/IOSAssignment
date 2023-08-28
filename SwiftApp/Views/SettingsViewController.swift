//
//  SettingsViewController.swift
//  SwiftApp
//
//  Created by Viktor van Hulle on 26/08/2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let api = Api()
    var currentCategory: String = "" // Default category
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
    
    var dailyPushQuote = ""
    var dailyPushQuoteAuthor = ""
    
    var pickerView = UIPickerView()

    private lazy var categoryTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter category"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Category"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var categoryDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter a category for your daily quote"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private lazy var dateTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select Time"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var dateDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose the time for your daily quote notification"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .time
        return datePicker
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Apply", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        //bg color
        button.backgroundColor = UIColor(hex: "#FF6B6B")
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapApply), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configSelector()
        
        //set the category to the saved category
        if let savedQuote = QuoteDataManager.shared.savedQuote {
            categoryTextField.text = savedQuote.category
        }
    }

    private func setupUI() {
        //background
        view.backgroundColor = .white
        
        //components
        view.addSubview(titleLabel)
        view.addSubview(categoryTitleLabel)
        view.addSubview(categoryTextField)
        view.addSubview(categoryDescriptionLabel)
        view.addSubview(dateTitleLabel)
        view.addSubview(datePicker)
        view.addSubview(dateDescriptionLabel)
        view.addSubview(applyButton)
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            categoryTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            categoryTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            categoryTextField.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor, constant: 8),
            categoryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            categoryDescriptionLabel.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor, constant: 2),
            categoryDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            dateTitleLabel.topAnchor.constraint(equalTo: categoryDescriptionLabel.bottomAnchor, constant: 20),
            dateTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            datePicker.topAnchor.constraint(equalTo: dateTitleLabel.bottomAnchor, constant: 8),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            dateDescriptionLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 2),
            dateDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            applyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            applyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            applyButton.widthAnchor.constraint(equalToConstant: 200),
            applyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    

    @objc func didTapApply(sender: UIButton) {
        currentCategory = categoryTextField.text!
        makeRandomCategoryPushQuote()
    }
    
    func configSelector(){
        pickerView.delegate = self
        pickerView.dataSource = self
        categoryTextField.inputView = pickerView
    }
    
    func makeRandomCategoryPushQuote() {
        
        api.loadData(for: currentCategory) { [weak self] quotes in
            guard let self = self, let randomQuote = quotes.randomElement() else {
                return
            }
            
            DispatchQueue.main.async {
                self.dailyPushQuote = randomQuote.quote
                self.dailyPushQuoteAuthor = randomQuote.author
                QuoteDataManager.shared.savedQuote = Quote(quote: randomQuote.quote, author: randomQuote.author, category: randomQuote.category)
                
                // Setup notification only after fetching and setting the correct data
                self.setupNotification()
            }
        }
    }
    
    func setupNotification(){
        
        let selectedDate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        let formattedTime = dateFormatter.string(from: selectedDate)
        
        //datepicker values
        datePicker.datePickerMode = .time
        let date = datePicker.date
        let components  = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = components.hour!
        let minute = components.minute!
        
        //notification config
        //identifier  for different notifications
        let  identifier = "quote-notification-one"
        let title = dailyPushQuoteAuthor
        let isDaily  = true
        
        let  notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = self.dailyPushQuote
        content.sound = .default
        
        
        print("should be the sdame: \(dailyPushQuote)--")
        
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        //removes pending request of identifier when date is changed
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
        
        }
    
    
    
    
}

  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */




//From "Easiest UIPickerView with UITextfield Xcode 11 Swift 5" tutorial
extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
