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

    @IBOutlet weak var categoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
        makeRandomPushQuote()
        updateQuote()
    }
    
    private func addGradientBackground() {
         let gradientLayer = CAGradientLayer()
         gradientLayer.colors = [UIColor(hex: "#FFEDE1").cgColor, UIColor(hex: "#D7F9FF").cgColor]
         gradientLayer.locations = [0.0, 1.0] // Customize your gradient locations
         gradientLayer.frame = view.bounds
         view.layer.insertSublayer(gradientLayer, at: 0)
     }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Quote Generator"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "The only limit to our realization of tomorrow will be our doubts of today."
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "- Franklin D. Roosevelt"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    private func createCategoryButton(title: String) -> UIButton {
         let button = UIButton(type: .system)
         button.translatesAutoresizingMaskIntoConstraints = false
         button.setTitle(title, for: .normal)
         button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.setTitleColor(.white, for: .normal)
         
         //bg color
         button.backgroundColor = UIColor(hex: "#FF6B6B")
         
         button.layer.cornerRadius = 5
         button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
         button.widthAnchor.constraint(equalToConstant: 250).isActive = true
         
         // Add drop shadow
         button.layer.shadowColor = UIColor.black.cgColor
         button.layer.shadowOpacity = 0.3
         button.layer.shadowOffset = CGSize(width: 0, height: 3)
         button.layer.shadowRadius = 6
         
         button.addTarget(self, action: #selector(didTapCategory), for: .touchUpInside)
         
         return button
     }

     // Using the createCategoryButton function
     private lazy var categoryBtn1: UIButton = createCategoryButton(title: "Settings")
     private lazy var categoryBtn2: UIButton = createCategoryButton(title: "Daily Quotes")
     private lazy var categoryBtn3: UIButton = createCategoryButton(title: "Favorites")
     private lazy var categoryBtn4: UIButton = createCategoryButton(title: "My Quotes")
    
    private lazy var categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    
    private func setupUI() {
        
        //background
        addOvalGradientLayers()
        addGradientBackground()
        
        
        //components
        view.addSubview(titleLabel)
        view.addSubview(quoteLabel)
        view.addSubview(authorLabel)
        view.addSubview(categoryStackView)
        
        
        for button in [categoryBtn1, categoryBtn2, categoryBtn3, categoryBtn4] {
            categoryStackView.addArrangedSubview(button)
        }
        
        categoryStackView.addArrangedSubview(categoryBtn1)
        categoryStackView.addArrangedSubview(categoryBtn2)
        categoryStackView.addArrangedSubview(categoryBtn3)
        categoryStackView.addArrangedSubview(categoryBtn4)
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            quoteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            quoteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            quoteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            authorLabel.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 5),
            authorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            categoryStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            categoryStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoryStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func addOvalGradientLayers() {
        let numberOfOvals = 5

        for i in 0..<numberOfOvals {
            let ovalLayer = createOvalGradientLayer(index: i, totalOvals: numberOfOvals)
            view.layer.insertSublayer(ovalLayer, at: 0)
        }
    }

    private func createOvalGradientLayer(index: Int, totalOvals: Int) -> CALayer {
        let ovalLayer = CAGradientLayer()
        //ovalLayer.colors = [UIColor.blue.cgColor, UIColor.white.cgColor] // Custom gradient colors
        ovalLayer.colors = [UIColor(hex: "#FFEDE1").cgColor, UIColor.white.cgColor] // Custom gradient colors
        ovalLayer.locations = [0.0, 1.0] // Custom gradient locations

        let ovalWidth = view.bounds.width * 0.5
        let ovalHeight = view.bounds.height * 0.5
        let ovalX = -ovalWidth / 2.0 + CGFloat(index) * view.bounds.width / CGFloat(totalOvals - 1)
        let ovalY = -ovalHeight / 2.0 + view.bounds.height * CGFloat(index) / CGFloat(totalOvals - 1)

        ovalLayer.frame = CGRect(x: ovalX, y: ovalY, width: ovalWidth, height: ovalHeight)
        ovalLayer.cornerRadius = ovalHeight / 2.0 // oval shape

        return ovalLayer
    }

    @objc func didTapCategory(sender: UIButton) {
        if let title = sender.currentTitle {
            switch title {
            case "Settings":
                 //animateOvalsOut() // Animate ovals when a navigation item is clicked
                 let settingsVC = SettingsViewController()
                 navigationController?.pushViewController(settingsVC, animated: true)
            case "Daily Quotes":
                print("Daily Quote")
                //navigationController?.pushViewController(dailyQuotesVC, animated: true)
            case "Favorites":
                let favoritesVC = FavoritesViewController()
                navigationController?.pushViewController(favoritesVC, animated: true)
            case "My Quotes":
                let myQuotesVC = MakeQuotesViewController()
                navigationController?.pushViewController(myQuotesVC, animated: true)
            default:
                break
            }
        }
    }

    func updateQuote() {
        api.loadData(for: "") { [weak self] quotes in
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
        
        api.loadData(for: "") { [weak self] quotes in
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

// UIColor extension to create colors from hex values
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgb & 0x0000FF) / 255.0,
                  alpha: 1.0)
    }
}
