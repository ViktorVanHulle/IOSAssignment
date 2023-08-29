//
//  MyQuotesCell.swift
//  SwiftApp
//
//  Created by Viktor van Hulle on 28/08/2023.
//

import Foundation
import UIKit

protocol MyQuotesCellDelegate: AnyObject {
    func favoriteButtonTapped(for quote: Quote)
    func deleteButtonTapped(for quote: Quote)
}

class MyQuotesCell: UITableViewCell {
    static let identifier = "MyQuotesCell"
    
    weak var delegate: MyQuotesCellDelegate?
    public var quote: Quote?
    
    public let quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var heartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
         let button = UIButton(type: .system)
         button.translatesAutoresizingMaskIntoConstraints = false
         button.setImage(UIImage(systemName: "trash"), for: .normal)
         button.tintColor = .red
         button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
         return button
     }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(deleteButton)
        contentView.addSubview(quoteLabel)
        contentView.addSubview(heartButton)
        
        NSLayoutConstraint.activate([
            deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 30),
            deleteButton.heightAnchor.constraint(equalToConstant: 30),
            
            quoteLabel.leadingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: 16),
            quoteLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            quoteLabel.trailingAnchor.constraint(equalTo: heartButton.leadingAnchor, constant: -16),
            
            heartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            heartButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            heartButton.widthAnchor.constraint(equalToConstant: 30),
            heartButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func configure(with quote: SwiftApp.Quote) {
        self.quote = quote
        quoteLabel.text = "\(quote.quote)\n- \(quote.author)"
        updateHeartButtonAppearance()
    }
    
    @objc private func deleteButtonTapped() {
        if let quote = quote {
            // Remove the quote from FavoritesManager first
            FavoritesManager.shared.removeQuoteFromFavorites(quote)
            
            // Notify the delegate to reload the table view data
            delegate?.deleteButtonTapped(for: quote)
        }
    }
    
    
    @objc public func heartButtonTapped() {
        if let quote = quote {
            delegate?.favoriteButtonTapped(for: quote)
            updateHeartButtonAppearance()
        }
    }
    
    private func updateHeartButtonAppearance() {
        if let quote = quote {
            if FavoritesManager.shared.favoriteQuotes.contains(where: {$0.quote == quote.quote}) {
                heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
}
