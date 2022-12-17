//
//  CoinMarketCellViewModel.swift
//  AlphaAltcoins
//
//  Created by Илья on 15.12.2022.
//

import Foundation

protocol CoinMarketCellViewModelProtocol {
    var coinSymbol: String { get }
    var coinName: String { get }
    var coinPrice: String { get }
    var imageData: String { get }
    var marketCup: String { get }
    var change7Day: String { get }
    var change24Hour: String { get }
    init(coin: AssetsCoin)
}

class CoinMarketCellViewModel: CoinMarketCellViewModelProtocol {
    var coinSymbol: String {
        "(\(coin.symbol))"
    }
    
    var coinName: String {
        coin.name
    }
    
    var coinPrice: String {
        "$\(coin.price)"
    }
    
    var imageData: String {
        "logo"
    }
    
    var marketCup: String {
        "$\(String(format: "%.2f", coin.marketCup))"
//        "$\(coin.marketCup)"
    }
    
    var change7Day: String {
        "(\(String(format: "%.2f", coin.change7Day))%)"
//        "\(coin.change7Day)"
    }
    
    var change24Hour: String {
        "(\(String(format: "%.2f", coin.change24Hour))%)"
    }
    
    private let coin : AssetsCoin
    
    required init(coin: AssetsCoin) {
//        guard let coin = coin else { return }
        self.coin = coin
    }
    
    private func removeCharacter(from text: String) -> Float {
        let newCharSet = CharacterSet.init(charactersIn: "-+$%")
        return getFloat(from: text.components(separatedBy: newCharSet).joined())
    }
    
    private func getFloat(from text: String) -> Float {
        Float(text) ?? 0
    }
}
