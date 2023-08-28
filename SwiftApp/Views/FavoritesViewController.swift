//
//  FavoritesViewController.swift
//  SwiftApp
//
//  Created by Viktor van Hulle on 26/08/2023.
//

import UIKit

class FavoritesViewController: BackgroundViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoriteQuoteCell.self, forCellReuseIdentifier: FavoriteQuoteCell.identifier)
        return tableView
    }()

    private var favoriteQuotes: [Quote] {
        return FavoritesManager.shared.favoriteQuotes
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Favorites"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return titleLabel
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    private func setupUI() {
        view.backgroundColor = .white
        // Add Title Label
        view.addSubview(titleLabel)
        // Add Table View
        view.addSubview(tableView)
        
        // Activate Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteQuotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteQuoteCell.identifier, for: indexPath) as! FavoriteQuoteCell
        let quote = favoriteQuotes[indexPath.row]
        cell.configure(with: quote)
        cell.delegate = self // Set the cell's delegate
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let quote = favoriteQuotes[indexPath.row]
        let text = "\(quote.quote)\n- \(quote.author)"
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17) // Adjust font size as needed
        label.text = text
        let size = label.sizeThatFits(CGSize(width: tableView.bounds.width - 32, height: CGFloat.greatestFiniteMagnitude))
        return size.height + 32 // Adjust padding as needed
    }
    
}

extension FavoritesViewController: FavoriteQuoteCellDelegate {
    func favoriteButtonTapped(for quote: Quote) {
        if let index = favoriteQuotes.firstIndex(where: { $0.quote == quote.quote}) {
            FavoritesManager.shared.removeQuoteFromFavorites(favoriteQuotes[index])
            tableView.reloadData()
        }
    }
}
