//
//  PortfolioViewModel.swift
//  AlphaAltcoins
//
//  Created by Илья on 13.12.2022.
//

import Foundation

protocol PortfolioViewModelProtocol {
    var navigationName: String { get }
}

class PortfolioViewModel: PortfolioViewModelProtocol {
    var navigationName: String = ""
}
