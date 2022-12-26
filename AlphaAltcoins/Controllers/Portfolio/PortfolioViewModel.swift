//
//  PortfolioViewModel.swift
//  AlphaAltcoins
//
//  Created by Илья on 13.12.2022.
//

import Foundation

protocol PortfolioViewModelProtocol {
    var walletBalance: String { get }
    var profitLabel: String { get }
    var viewModelDidChange: ((PortfolioViewModelProtocol) -> Void)? { get set }
    func reloadBalance(for label: String) -> String
    func fetchMarkets(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func getPortfolioCellViewModel(at indexPath: IndexPath) -> PortfolioCellViewModelProtocol
}

final class PortfolioViewModel: PortfolioViewModelProtocol {
    // MARK: - Public Properties
    var walletBalance: String {
        get {
            reloadBalance()
        }
        set {
            viewModelDidChange?(self)
        }
    }
    var profitLabel: String {
        get {
            profit ?? ""
        }
        set {
            viewModelDidChange?(self)
        }
    }
    var viewModelDidChange: ((PortfolioViewModelProtocol) -> Void)?
    
    // MARK: - Private Properties
    private var wallet: String?
    private var profit: String?
    private var coins: [CoinInfo] = []

    // MARK: - Public methods
    func fetchMarkets(completion: @escaping () -> Void) {
        coins = [CoinInfo(name: "bitcoin",
                          totalPrice: "1300",
                          amountCoins: "1",
                          buyPriceCoin: "700$",
                          imageCoin: "logo",
                          percent: "+10%",
                          gainMoney: "+310$",
                          exchange: "binance",
                          symbol: "btc",
                          baseAsset: "btc",
                          quoteAsset: "usdt",
                          status: "",
                          priceUnconverted: 0,
                          price: 1000,
                          change24Hour: 0,
                          spread: 0,
                          volume24Hour: 0,
                          created: "",
                          updated: ""),
                 CoinInfo(name: "Dollar",
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
                          status: "",
                          priceUnconverted: 0,
                          price: 1000,
                          change24Hour: 0,
                          spread: 0,
                          volume24Hour: 0,
                          created: "",
                          updated: "")]
        //        coins = StorageManager.shared.fetchCoins()
        completion()
    }
    
    func reloadBalance(for label: String = "") -> String {
        var newWallet: Float = 0
        var newProfit: Float = 0
        
        coins.forEach { coin in
            guard let totalPrice = coin.totalPrice,
                  let gainProfit = coin.gainMoney
            else { return }
            
            let total = removeCharacter(
                from: totalPrice)
            let procent = removeCharacter(
                from: gainProfit)
            
            calculateWallet(validation: gainProfit,
                            from: total,
                            with: procent,
                            completion: { newWallet += $0 })
            
            calculateWallet(validation: gainProfit,
                            from: 0,
                            with: procent,
                            completion: { newProfit += $0 })
        }
        profit = "\(String(format: "%.2f", newProfit))"
        return "$\(String(format: "%.2f", newWallet))"
    }
    
    func numberOfRows() -> Int {
        coins.count
    }
    
    func getPortfolioCellViewModel(at indexPath: IndexPath) -> PortfolioCellViewModelProtocol {
        PortfolioCellViewModel(coin: coins[indexPath.row])
    }
    
    // MARK: - Private methods
    private func removeCharacter(from text: String) -> Float {
        let newCharSet = CharacterSet.init(charactersIn: "-+$%")
        return getFloat(from: text.components(separatedBy: newCharSet).joined())
    }
    
    private func getFloat(from text: String) -> Float {
        Float(text) ?? 0
    }
    
    private func calculateWallet(
        validation: String,
        from total: Float,
        with profit: Float,
        completion: @escaping(Float) -> Void) {
            
            (validation.contains("-"))
            ? (completion(total - profit))
            : (completion(total + profit))
        }
}
