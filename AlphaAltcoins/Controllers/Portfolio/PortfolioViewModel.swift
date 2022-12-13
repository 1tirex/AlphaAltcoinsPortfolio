//
//  PortfolioViewModel.swift
//  AlphaAltcoins
//
//  Created by Илья on 13.12.2022.
//

import Foundation

protocol PortfolioViewModelProtocol {
//    var navigationName: String { get }
//    init(markets: MarketsInfo)
    func fetchMarkets(completion: @escaping() -> Void)
    func numberOfRows() -> Int
}

class PortfolioViewModel: PortfolioViewModelProtocol {
    func fetchMarkets(completion: @escaping () -> Void) {
        
    }
    
    func numberOfRows() -> Int {
        <#code#>
    }
    
    
}
