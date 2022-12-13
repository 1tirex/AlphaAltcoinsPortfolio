//
//  PortfolioCell.swift
//  AlphaAltcoins
//
//  Created by Илья on 14.12.2022.
//

import UIKit

class PortfolioCell: UITableViewCell {
    static let identifier = "PortfolioCell"
    var viewModel: PortfolioCellViewModelProtocol! {
        didSet {
            var content = defaultContentConfiguration()
            content.text = viewModel.coinName
            guard let imageData = viewModel.imageData else { return }
            content.image = UIImage(named: imageData)
            contentConfiguration = content
        }
    }
}
