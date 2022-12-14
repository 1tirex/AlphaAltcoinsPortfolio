//
//  PortfolioCell.swift
//  AlphaAltcoins
//
//  Created by Илья on 14.12.2022.
//

import UIKit

class PortfolioCell: UITableViewCell {
    static let identifier = "PortfolioCell"
    
    let coinName = UILabel()
    let coinTotal = UILabel()
    let coinPrice = UILabel()
    let gainProfit = UILabel()
    let coinExchenge = UILabel()
    let coinImage = UIImageView()
    
    var viewModel: PortfolioCellViewModelProtocol! {
        didSet {
            coinName.text = viewModel.coinName
            coinTotal.text = viewModel.coinTotal
            coinPrice.text = viewModel.coinPrice
            gainProfit.text = viewModel.gainProfit
            gainProfit.textColor = UIColor.colorWith(name: viewModel.color)
            coinExchenge.text = viewModel.exchenge
            coinImage.image = UIImage(named: viewModel.imageData)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(coinName, coinTotal, coinPrice, gainProfit, coinExchenge, coinImage)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    private func configure() {
        coinImage.contentMode = .scaleAspectFit
        coinImage.layer.cornerRadius = 20
        coinImage.backgroundColor = UIColor.colorWith(name: Resources.Colors.background)
        coinImage.clipsToBounds = true
        setConstraints()
    }
    
    private func setConstraints() {
        coinImage.translatesAutoresizingMaskIntoConstraints = false
        coinImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        coinImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        coinImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        coinImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        coinName.translatesAutoresizingMaskIntoConstraints = false
        coinName.numberOfLines = 1
        coinName.font = UIFont.helvelticaRegular(with: 17)
        coinName.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        coinName.leadingAnchor.constraint(equalTo: self.coinImage.trailingAnchor, constant: 10).isActive = true
        
        coinPrice.translatesAutoresizingMaskIntoConstraints = false
        coinPrice.numberOfLines = 1
        coinPrice.font = UIFont.helvelticaRegular(with: 15)
        coinPrice.textColor = UIColor.colorWith(name: Resources.Colors.inActive)
        coinPrice.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        coinPrice.leadingAnchor.constraint(equalTo: self.coinImage.trailingAnchor, constant: 10).isActive = true
        
        coinTotal.translatesAutoresizingMaskIntoConstraints = false
        coinTotal.numberOfLines = 1
        coinTotal.font = UIFont.helvelticaRegular(with: 17)
        coinTotal.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        coinTotal.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
        gainProfit.translatesAutoresizingMaskIntoConstraints = false
        gainProfit.font = UIFont.helvelticaRegular(with: 15)
        gainProfit.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        gainProfit.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
}
