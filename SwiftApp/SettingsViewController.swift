//
//  SettingsViewController.swift
//  SwiftApp
//
//  Created by Viktor van Hulle on 26/08/2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var datepicker: UIDatePicker!
    
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
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    var pickerView = UIPickerView()


    override func viewDidLoad() {
        super.viewDidLoad()
        configSelector()
        // Do any additional setup after loading the view.
    }

    
    func configSelector(){
        pickerView.delegate = self
        pickerView.dataSource = self
        categoryTextField.inputView = pickerView
        
    }
    
    @IBAction func changeCategoryButton(_ sender: UIButton) {
        if let newCategory = categoryTextField.text {
           currentCategory = newCategory
        }
        configSelectedTime()

    }
    
    
    func configSelectedTime(){
        
        //datepicker values
        datepicker.datePickerMode = .time
        let date = datepicker.date
        let components  = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = components.hour!
        let minute = components.minute!

        //notification config
        let  identifier = "quote-notification-one"
        
        let  notificationCenter = UNUserNotificationCenter.current()
        
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        let  isDaily = true
        

        //get current notification and change it
        notificationCenter.getPendingNotificationRequests(completionHandler: {requests -> () in
            for request in requests {
                if(request.identifier == identifier){
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
                    let request = UNNotificationRequest(identifier: identifier, content: request.content, trigger: trigger)
                    
                    //removes pending request of identifier when date is changed
                    notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
                    notificationCenter.add(request)
                }
                    
            }})
        

            
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
