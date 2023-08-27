//
//  ViewController.swift
//  SwiftApp
//
//  Created by Viktor van Hulle on 25/08/2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    let api = Api()
    var dailyPushQuote = ""
    var dailyPushQuoteAuthor = ""

    var currentCategory: String = "happiness" // Default category
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var categoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeRandomPushQuote()
        updateQuote()
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
    
    //push notification from "Hoz to add Local push notifications to your IOS app with swift" tutorial
    func checkForPermission(){
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings{ settings in
            switch settings.authorizationStatus{
            case .authorized:
                self.dispatchNotification()
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]){
                    didAllow, error in
                    if didAllow {
                        self.dispatchNotification()
                    }
                }
            default:
                return
        }
        }
    }
    
    func makeRandomPushQuote() {
        
        api.loadData(for: currentCategory) { [weak self] quotes in
            guard let self = self, let randomQuote = quotes.randomElement() else {
                return
            }
            
            DispatchQueue.main.async {
                self.dailyPushQuote = randomQuote.quote
                self.dailyPushQuoteAuthor = randomQuote.author
            }
            
            checkForPermission()
        }
        
    }
    
    func dispatchNotification(){
    
        //notification config
        //identifier  for different notifications
        let  identifier = "quote-notification-one"
        let title = dailyPushQuoteAuthor
        //define hour of day
        let hour = 12
        let minute = 00
        let isDaily  = true
        
        let  notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = dailyPushQuote
        content.sound = .default
        
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
