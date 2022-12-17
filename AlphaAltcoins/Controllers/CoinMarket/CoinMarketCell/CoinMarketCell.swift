//
//  CoinMarketCell.swift
//  AlphaAltcoins
//
//  Created by Илья on 15.12.2022.
//

import UIKit

class CoinMarketCell: UITableViewCell {
    static let identifier = "CoinMarketCell"
    
    let coinName = UILabel()
    let coinPrice = UILabel()
    let marketCup = UILabel()
    let coinSymbol = UILabel()
    let change7Day = UILabel()
    let change24Hour = UILabel()
    let coinImage = UIImageView()
    
    var viewModel: CoinMarketCellViewModelProtocol! {
        didSet {
            coinName.text = viewModel.coinName
            coinSymbol.text = viewModel.coinSymbol
            coinPrice.text = viewModel.coinPrice
            coinImage.image = UIImage(named: viewModel.imageData)
            marketCup.text = viewModel.marketCup
            change7Day.text = viewModel.change7Day
            change24Hour.text = viewModel.change24Hour
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(coinName, coinSymbol, coinPrice, coinImage, marketCup, change24Hour, change7Day)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configure() {
        coinImage.contentMode = .scaleAspectFit
        coinImage.layer.cornerRadius = 20
        coinImage.backgroundColor = UIColor.colorWith(name: Resources.Colors.background)
        coinImage.clipsToBounds = true
        setConstraints()
    }
    
    private func setLabel(for label: UILabel,
                          size: Double,
                          color: UIColor? = nil) {
        
        label.numberOfLines = 1
        label.font = UIFont.helvelticaRegular(with: size)
        label.textColor = color
    }
    
    private func setConstraints() {
        change7Day.isHidden = true
        setLabel(for: coinName, size: 17)
        setLabel(for: coinPrice, size: 17)
        setLabel(for: coinSymbol, size: 14, color: UIColor.colorWith(name: Resources.Colors.inActive))
        setLabel(for: marketCup, size: 14, color: UIColor.colorWith(name: Resources.Colors.inActive))
        setLabel(for: change24Hour, size: 14, color: UIColor.colorWith(name: Resources.Colors.inActive))
        setLabel(for: change7Day, size: 14, color: UIColor.colorWith(name: Resources.Colors.inActive))
        
        NSLayoutConstraint.activate([
            coinImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            coinImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            coinImage.widthAnchor.constraint(equalToConstant: 40),
            coinImage.heightAnchor.constraint(equalToConstant: 40),
            
            coinName.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            coinName.leadingAnchor.constraint(equalTo: coinImage.trailingAnchor, constant: 20),
            
            coinSymbol.centerYAnchor.constraint(equalTo: coinName.centerYAnchor),
            coinSymbol.leadingAnchor.constraint(equalTo: coinName.trailingAnchor, constant: 5),
            
            marketCup.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            marketCup.leadingAnchor.constraint(equalTo: coinName.leadingAnchor),
            
            coinPrice.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            coinPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            change24Hour.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            change24Hour.trailingAnchor.constraint(equalTo: coinPrice.trailingAnchor)
        ])
    }
}
