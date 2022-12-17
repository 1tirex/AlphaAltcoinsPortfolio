//
//  CoinModel.swift
//  AlphaAltcoins
//
//  Created by Илья on 13.12.2022.
//

import Foundation

// MARK: - CoinsMarketsInfo
struct CoinsMarketsInfo: Codable {
    let markets: [CoinInfo]
    let next: String
}

struct CoinInfo: Codable {
    let name: String?
    let percent: String?
    let gainMoney: String?
    let imageCoin: String?
    let totalPrice: String?
    let amountCoins: String?
    let buyPriceCoin: String?
    let symbol: String
    let status: String
    let created: String
    let updated: String
    let exchange: String
    let baseAsset: String
    let quoteAsset: String
    let price: Float
    let spread: Float
    let change24Hour: Float
    let volume24Hour: Float
    let priceUnconverted: Float
    
    
    init(name: String, totalPrice: String, amountCoins: String,
         buyPriceCoin: String, imageCoin: String, percent: String,
         gainMoney: String, exchange: String, symbol: String,
         baseAsset: String, quoteAsset: String, status: String,
         priceUnconverted: Float, price: Float,
         change24Hour: Float, spread: Float, volume24Hour: Float,
         created: String, updated: String) {
        self.name = name
        self.price = price
        self.symbol = symbol
        self.spread = spread
        self.status = status
        self.created = created
        self.updated = updated
        self.percent = percent
        self.exchange = exchange
        self.imageCoin = imageCoin
        self.gainMoney = gainMoney
        self.baseAsset = baseAsset
        self.quoteAsset = quoteAsset
        self.totalPrice = totalPrice
        self.amountCoins = amountCoins
        self.change24Hour = change24Hour
        self.volume24Hour = volume24Hour
        self.buyPriceCoin = buyPriceCoin
        self.priceUnconverted = priceUnconverted
    }
    
    enum CodingKeys: String, CodingKey {
        case created = "created_at"
        case updated = "updated_at"
        case exchange = "exchange_id"
        case baseAsset = "base_asset"
        case quoteAsset = "quote_asset"
        case change24Hour = "change_24h"
        case volume24Hour = "volume_24h"
        case priceUnconverted = "price_unconverted"
        case name, totalPrice
        case price, spread, status
        case percent, gainMoney, symbol
        case amountCoins, buyPriceCoin, imageCoin
    }
}

// MARK: - Assets
struct Assets: Codable {
    let assets: [AssetsCoin]?
    let asset: AssetsCoin?
    let next: String?
}

struct AssetsCoin: Codable {
    let symbol: String
    let name: String
    let description: String
    let price: Float
    let volume24Hour: Float
    let change1Hour: Float
    let change24Hour: Float
    let change7Day: Float
    let totalSupply: Float
    let maxSupply: Float?
    let marketCup: Float
    
    enum CodingKeys: String, CodingKey {
        case symbol = "asset_id"
        case name
        case description
        case price
        case volume24Hour = "volume_24h"
        case change1Hour = "change_1h"
        case change24Hour = "change_24h"
        case change7Day = "change_7d"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case marketCup = "market_cap"
    }
}
