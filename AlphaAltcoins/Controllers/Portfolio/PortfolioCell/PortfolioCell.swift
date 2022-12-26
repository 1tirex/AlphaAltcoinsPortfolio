//
//  PortfolioCell.swift
//  AlphaAltcoins
//
//  Created by Илья on 14.12.2022.
//

import UIKit

final class PortfolioCell: UITableViewCell {
    // MARK: - Public Properties
    static let identifier = "PortfolioCell"
    
    var viewModel: PortfolioCellViewModelProtocol! {
        didSet {
            coinName.text = viewModel.coinName
            coinTotal.text = viewModel.coinTotal
            coinAmount.text = viewModel.coinAmount
            gainProfit.text = viewModel.gainProfit
            gainProfit.textColor = UIColor.colorWith(name: viewModel.color)
            coinExchenge.text = viewModel.exchenge
            coinImage.image = UIImage(named: viewModel.imageData)
        }
    }
    
    // MARK: - Private Properties
    private let coinName = UILabel()
    private let coinTotal = UILabel()
    private let coinAmount = UILabel()
    private let gainProfit = UILabel()
    private let coinExchenge = UILabel()
    private let coinImage = UIImageView()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Properties
    private func configure() {
        addSubviews(coinName, coinTotal, coinAmount, gainProfit, coinExchenge, coinImage)
        coinImage.contentMode = .scaleAspectFit
        coinImage.layer.cornerRadius = 20
        coinImage.backgroundColor = UIColor.colorWith(name: Resources.Colors.background)
        coinImage.clipsToBounds = true
        setConstraints()
    }
    private func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    private func setConstraints() {
        // Image
        coinImage.translatesAutoresizingMaskIntoConstraints = false
        coinImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        coinImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        coinImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        coinImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // Name
        coinName.translatesAutoresizingMaskIntoConstraints = false
        coinName.numberOfLines = 1
        coinName.font = UIFont.helvelticaRegular(with: 17)
        coinName.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        coinName.leadingAnchor.constraint(equalTo: self.coinImage.trailingAnchor, constant: 10).isActive = true
        
        // Amount
        coinAmount.translatesAutoresizingMaskIntoConstraints = false
        coinAmount.numberOfLines = 1
        coinAmount.font = UIFont.helvelticaRegular(with: 15)
        coinAmount.textColor = UIColor.colorWith(name: Resources.Colors.inActive)
        coinAmount.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        coinAmount.leadingAnchor.constraint(equalTo: self.coinImage.trailingAnchor, constant: 10).isActive = true
        
        // Total
        coinTotal.translatesAutoresizingMaskIntoConstraints = false
        coinTotal.numberOfLines = 1
        coinTotal.font = UIFont.helvelticaRegular(with: 17)
        coinTotal.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        coinTotal.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
        // Profit
        gainProfit.translatesAutoresizingMaskIntoConstraints = false
        gainProfit.font = UIFont.helvelticaRegular(with: 15)
        gainProfit.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        gainProfit.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
}
