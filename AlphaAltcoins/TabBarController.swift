//
//  TabBarController.swift
//  AlphaAltcoins
//
//  Created by Илья on 13.12.2022.
//

import UIKit

//enum Tabs {
//    case homePage
//    case search //favorite
//    case add
//    case alerts
//    case profile
//}

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        tabBar.tintColor = .systemIndigo
        tabBar.backgroundColor = nil
        
        let portfolioController = UINavigationController(rootViewController: UIViewController())
        let coinMarketController = UINavigationController(rootViewController: UIViewController())
        let addingController = UINavigationController(rootViewController: UIViewController())
        let alertsController = UINavigationController(rootViewController: UIViewController())
        let profileController = UINavigationController(rootViewController: UIViewController())
        
        portfolioController.tabBarItem.image = UIImage(systemName: "briefcase")
        coinMarketController.tabBarItem.image = UIImage(systemName: "chart.bar")
        addingController.tabBarItem.image = UIImage(systemName: "plus.diamond")
        alertsController.tabBarItem.image = UIImage(systemName: "bell")
        profileController.tabBarItem.image = UIImage(systemName: "person")
        
        setViewControllers([
            portfolioController,
            coinMarketController,
            addingController,
            alertsController,
            profileController
        ], animated: false)
    }
}
