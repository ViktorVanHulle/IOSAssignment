//
//  MakeQuotesViewController.swift
//  SwiftApp
//
//  Created by Viktor van Hulle on 26/08/2023.
//

import UIKit

class MakeQuotesViewController: UIViewController {

    private lazy var favoritesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Quotes"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(favoritesLabel)
        
        NSLayoutConstraint.activate([
            favoritesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoritesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
