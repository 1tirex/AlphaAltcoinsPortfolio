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
    var coinAmount: String { get }
    var gainProfit: String { get }
    var imageData: String { get }
    var exchenge: String { get }
    var color: String { get }
    init(coin: CoinInfo)
}

final class PortfolioCellViewModel: PortfolioCellViewModelProtocol {
    // MARK: - Public Properties
    var coinAmount: String {
        "\(coin.amountCoins ?? "0.00") \(coin.symbol.uppercased())"
    }
    var color: String {
        choiceColor(validation: gainProfit)
    }
    var coinTotal: String {
        "$\(String(format: "%.2f", removeCharacter(from: coin.totalPrice ?? "")))"
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
    
    // MARK: - Private Properties
    private let coin : CoinInfo
    
    // MARK: - Initializers
    required init(coin: CoinInfo) {
        self.coin = coin
    }
    
    // MARK: - Private Methods
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
