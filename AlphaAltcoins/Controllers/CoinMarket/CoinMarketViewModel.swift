//
//  CoinMarketViewModel.swift
//  AlphaAltcoins
//
//  Created by Илья on 13.12.2022.
//

import Foundation

protocol CoinMarketViewModelProtocol {
    func numberOfRows(for: Bool) -> Int
    func getCoinMarketViewModel(at indexPath: IndexPath, for: Bool) -> CoinMarketCellViewModelProtocol
    func fetchCoins(completion: @escaping() -> Void)
    func fetchSearch(from: String, completion: @escaping() -> Void)
}

final class CoinMarketViewModel: CoinMarketViewModelProtocol {
    
    // MARK: - Public Properties
    private var foundСoin: AssetsCoin?
    private var coins: [AssetsCoin] = []
    
    // MARK: - Public methods
    func fetchCoins(completion: @escaping () -> Void) {
        NetworkManager.shared.fetch(
            type: Assets.self,
            needFor: .assetsCoin,
            completion: { [unowned self] result in
                switch result {
                case .success(let loadCoin):
                    self.coins = loadCoin.assets ?? []
                case .failure(let error):
                    print(error)
                }
                completion()
            })
    }
    
    func fetchSearch(from coin: String, completion: @escaping () -> Void) {
        NetworkManager.shared.fetch(
            type: Assets.self,
            needFor: .coinSearch,
            coin: coin.lowercased(),
            completion: { [unowned self] result in
                switch result {
                case .success(let loadCoin):
                    self.filterContentForSearchText(coin, loadCoin.asset)
                case .failure(let error):
                    print(error)
                }
                completion()
            })
    }
    
    func numberOfRows(for activity: Bool) -> Int {
        activity ? 1 : coins.count
    }
    
    func getCoinMarketViewModel(at indexPath: IndexPath, for activity: Bool) -> CoinMarketCellViewModelProtocol {
        activity
        ? CoinMarketCellViewModel(coin: foundСoin ?? AssetsCoin(symbol: "coin",
                                                                name: "Not found",
                                                                description: "",
                                                                price: 0,
                                                                volume24Hour: 0,
                                                                change1Hour: 0,
                                                                change24Hour: 0,
                                                                change7Day: 0,
                                                                totalSupply: 0,
                                                                maxSupply: nil,
                                                                marketCup: 0))
        : CoinMarketCellViewModel(coin: coins[indexPath.row])
    }
    
    // MARK: - Private methods
    private func filterContentForSearchText(_ searchText: String,
                                            _ loadMarket: AssetsCoin?) {
        if loadMarket?.symbol.uppercased() == searchText.uppercased() {
            foundСoin = loadMarket
        } else {
            print("not found coin")
        }
    }
}

enum StutusAlert: String {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success: return "Success"
        case .failed: return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success: return  "Good job"
        case .failed: return "Please check the entered data. All fields must be filled."
        }
    }
}
