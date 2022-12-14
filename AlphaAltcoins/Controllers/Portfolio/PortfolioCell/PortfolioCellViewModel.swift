//
//  PortfolioCellViewModel.swift
//  AlphaAltcoins
//
//  Created by Илья on 14.12.2022.
//

import Foundation

protocol PortfolioCellViewModelProtocol {
    var coinName: String { get }
    var coinTotal: String { get }
    var coinPrice: String { get }
    var gainPercent: String { get }
    var gainProfit: String { get }
    var imageData: String { get }
    var exchenge: String { get }
    var color: String { get }
    init(coin: MarketsInfo)
}

class PortfolioCellViewModel: PortfolioCellViewModelProtocol {
    var coinPrice: String {
        coin.totalPrice ?? ""
    }
    
    var color: String {
        choiceColor(validation: gainPercent)
    }
    
    var coinTotal: String {
        coin.totalPrice ?? ""
    }
    
    var gainPercent: String {
        coin.percent ?? ""
    }
    
    var gainProfit: String {
        coin.gainMoney ?? ""
    }
    
    var exchenge: String {
        coin.exchange
    }
    
    var coinName: String {
        coin.name ?? ""
    }
    
    var imageData: String {
        "logo"
    }
    
    private let coin : MarketsInfo
    
    required init(coin: MarketsInfo) {
        self.coin = coin
    }
    
    private func choiceColor(validation: String) -> String {
        
        (validation.contains("-"))
        ? "systemPink"
        : "green"
    }
}
