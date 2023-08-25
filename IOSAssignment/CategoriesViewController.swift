//
//  PeopleViewController.swift
//  IOSAssignment
//
//  Created by Viktor van Hulle on 25/08/2023.
//

import UIKit

class CategoriesViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Categories"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    private lazy var categoryBtns: [UIButton] = {
        let titles = ["Settings", "Daily Quotes", "Favorites", "My Quotes"]
        let buttons = titles.map { title -> UIButton in
            let btn = UIButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitleColor(.blue, for: .normal)
            btn.setTitle(title, for: .normal)
            btn.addTarget(self, action: #selector(didTapCategory), for: .touchUpInside)
            return btn
        }
        return buttons
    }()
    
    private lazy var categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(categoryStackView)
        
        for button in categoryBtns {
            categoryStackView.addArrangedSubview(button)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            categoryStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            categoryStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoryStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    @objc func didTapCategory(sender: UIButton) {
        if let title = sender.currentTitle {
            switch title {
            case "Settings":
                let settingsVC = SettingsViewController()
                navigationController?.pushViewController(settingsVC, animated: true)
            case "Daily Quotes":
                let dailyQuotesVC = DailyQuotesViewController()
                navigationController?.pushViewController(dailyQuotesVC, animated: true)
            case "Favorites":
                let favoritesVC = FavoritesViewController()
                navigationController?.pushViewController(favoritesVC, animated: true)
            case "My Quotes":
                let myQuotesVC = MyQuotesViewController()
                navigationController?.pushViewController(myQuotesVC, animated: true)
            default:
                break
            }
        }
    }
}
