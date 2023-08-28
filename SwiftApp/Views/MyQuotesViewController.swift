//
//  MyQuotesViewController.swift
//  SwiftApp
//
//  Created by Viktor van Hulle on 29/08/2023.
//

import UIKit

protocol MyQuotesViewControllerDelegate: AnyObject {
    func didAddNewQuote()
}

class MyQuotesViewController: BackgroundViewController {
    
    //to reload tableview on addquote
    weak var delegate: MyQuotesViewControllerDelegate?

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoriteQuoteCell.self, forCellReuseIdentifier: FavoriteQuoteCell.identifier)
        return tableView
    }()
    
    private var myQuotes: [Quote] {
        return QuoteDataManager.shared.myQuotes
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "My Quotes"
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
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addQuoteButtonTapped)
        )
    }
    
    @objc private func addQuoteButtonTapped() {
        // Handle adding a new quote here
        let makeQuoteVC = MakeQuotesViewController()
        navigationController?.pushViewController(makeQuoteVC, animated: true)
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


extension MyQuotesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myQuotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteQuoteCell.identifier, for: indexPath) as! FavoriteQuoteCell
        let quote = myQuotes[indexPath.row]
        cell.configure(with: quote)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let quote = myQuotes[indexPath.row]
        let text = "\(quote.quote)\n- \(quote.author)"
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17) // Adjust font size as needed
        label.text = text
        let size = label.sizeThatFits(CGSize(width: tableView.bounds.width - 32, height: CGFloat.greatestFiniteMagnitude))
        return size.height + 32 // Adjust padding as needed
    }
}



extension MyQuotesViewController: FavoriteQuoteCellDelegate {
    func favoriteButtonTapped(for quote: Quote) {
        if let index = FavoritesManager.shared.favoriteQuotes.firstIndex(where: { $0.quote == quote.quote}) {
            FavoritesManager.shared.removeQuoteFromFavorites(FavoritesManager.shared.favoriteQuotes[index])
            tableView.reloadData()
        }else {
            FavoritesManager.shared.addQuoteToFavorites(quote) // Add the quote to favorites
            tableView.reloadData()
        }
    }
}
