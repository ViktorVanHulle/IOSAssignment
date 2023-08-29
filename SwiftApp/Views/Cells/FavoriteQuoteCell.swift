//
//  FavoriteQuoteCell.swift
//  SwiftApp
//
//  Created by Viktor van Hulle on 28/08/2023.
//

import Foundation


import UIKit

protocol FavoriteQuoteCellDelegate: AnyObject {
    func favoriteButtonTapped(for quote: Quote)
}

class FavoriteQuoteCell: UITableViewCell {
    static let identifier = "FavoriteQuoteCell"
    
    weak var delegate: FavoriteQuoteCellDelegate?
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(quoteLabel)
        contentView.addSubview(heartButton)
        
        NSLayoutConstraint.activate([
            quoteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

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
