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
    let gainPercent = UILabel()
    let gainProfit = UILabel()
    let coinExchenge = UILabel()
    let coinImage = UIImageView()
    
    var viewModel: PortfolioCellViewModelProtocol! {
        didSet {
            coinName.text = viewModel.coinName
            coinTotal.text = viewModel.coinTotal
            coinPrice.text = viewModel.coinPrice
            gainPercent.text = viewModel.gainPercent
            gainPercent.textColor = UIColor.colorWith(name: viewModel.color)
            gainProfit.text = viewModel.gainProfit
            gainProfit.textColor = UIColor.colorWith(name: viewModel.color)
            coinExchenge.text = viewModel.exchenge
            coinImage.image = UIImage(named: viewModel.imageData)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(coinName, coinTotal, gainProfit, gainPercent, coinExchenge, coinImage)
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
//        coinImage.backgroundColor = UIColor.colorWith(name: Resources.Colors.background)
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
        coinName.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        coinName.leadingAnchor.constraint(equalTo: coinImage.trailingAnchor, constant: 10).isActive = true
        //fonts
        
        coinPrice.translatesAutoresizingMaskIntoConstraints = false
        coinPrice.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20).isActive = true
        coinPrice.leadingAnchor.constraint(equalTo: coinImage.trailingAnchor, constant: 10).isActive = true
    }
}
