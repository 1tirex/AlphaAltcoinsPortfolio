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
    var gainProfit: String { get }
    var imageData: String { get }
    var exchenge: String { get }
    var color: String { get }
    init(coin: MarketsInfo)
}

class PortfolioCellViewModel: PortfolioCellViewModelProtocol {
    var coinPrice: String {
        "\(String(format: "%.2f", coin.price))$"
    }
    
    var color: String {
        choiceColor(validation: gainProfit)
    }
    
    var coinTotal: String {
        "\(String(format: "%.2f", removeCharacter(from: coin.totalPrice ?? "")))$"
    }
    
    var gainProfit: String {
        "\(coin.gainMoney ?? "") (\(coin.percent ?? ""))"
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
        : "systemGreen"
    }
    

    
    private func removeCharacter(from text: String) -> Float {
        let newCharSet = CharacterSet.init(charactersIn: "-+$%")
        return getFloat(from: text.components(separatedBy: newCharSet).joined())
    }
    
    private func getFloat(from text: String) -> Float {
        Float(text) ?? 0
    }
}
