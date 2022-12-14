//
//  PortfolioViewModel.swift
//  AlphaAltcoins
//
//  Created by Илья on 13.12.2022.
//

import Foundation

protocol PortfolioViewModelProtocol {
    var walletLabel: String { get }
    func reloadWallet() -> String
    func fetchMarkets(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func getPortfolioCellViewModel(at indexPath: IndexPath) -> PortfolioCellViewModelProtocol
}

class PortfolioViewModel: PortfolioViewModelProtocol {
    func getPortfolioCellViewModel(at indexPath: IndexPath) -> PortfolioCellViewModelProtocol {
        PortfolioCellViewModel(coin: coins[indexPath.row])
    }
    
    var walletLabel: String {
        reloadWallet()
    }
    
    private var coins: [MarketsInfo] = []
    
    func fetchMarkets(completion: @escaping () -> Void) {
        coins = [MarketsInfo(name: "bitcoin",
                            totalPrice: "1300",
                            amountCoins: "1",
                            buyPriceCoin: "700$",
                            imageCoin: "logo",
                            percent: "+10%",
                            gainMoney: "+300$",
                            exchange: "binance",
                            symbol: "btc",
                            baseAsset: "btc",
                            quoteAsset: "usdt",
                            priceUnconverted: 0,
                            price: 1000,
                            change24Hour: 0,
                            spread: 0,
                            volume24Hour: 0,
                            status: "",
                            created: "",
                             updated: ""),
                 MarketsInfo(name: "Dollar",
                                     totalPrice: "1300",
                                     amountCoins: "1",
                                     buyPriceCoin: "700$",
                                     imageCoin: "logo",
                                     percent: "-10%",
                                     gainMoney: "-300$",
                                     exchange: "binance",
                                     symbol: "btc",
                                     baseAsset: "btc",
                                     quoteAsset: "usdt",
                                     priceUnconverted: 0,
                                     price: 1000,
                                     change24Hour: 0,
                                     spread: 0,
                                     volume24Hour: 0,
                                     status: "",
                                     created: "",
                                     updated: "")]
//        coins = StorageManager.shared.fetchCoins()
        completion()
    }
    
    func numberOfRows() -> Int {
        coins.count
    }
    
    func reloadWallet() -> String {
        var newWallet: Float = 0
        
        coins.forEach { coin in
            guard let totalPrice = coin.totalPrice,
                  let gainProcent = coin.gainMoney
            else { return }
            
            let total = getFloat(
                from: removeCharacterSets(from: totalPrice))
            let procent = getFloat(
                from: removeCharacterSets(
                    from: gainProcent))
            var wallet = getFloat(
                from: removeCharacterSets(
                    from: walletLabel))
            
            calculateWallet(validation: gainProcent,
                            from: total,
                            with: procent,
                            completion: { wallet += $0 })
            
            newWallet = wallet
        }
        return "\(String(format: "%.2f", newWallet))$"
    }
    
    private func getFloat(from text: String) -> Float {
        Float(text) ?? 0
    }
    
    private func removeCharacterSets(from text: String) -> String {
        let newCharSet = CharacterSet.init(charactersIn: "-+$%")
        return text.components(separatedBy: newCharSet).joined()
    }
    
    private func calculateWallet(validation: String,
                                 from total: Float,
                                 with procent: Float,
                                 completion: @escaping(Float) -> Void) {
        
        (validation.contains("-"))
        ? (completion(total - procent))
        : (completion(total + procent))
    }
}
