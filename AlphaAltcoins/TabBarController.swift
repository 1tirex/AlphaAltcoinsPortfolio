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
        
//        let rgba = CGColor(red: 115/255, green: 250/255, blue: 121/255, alpha: 1.0)
//        tabBar.layer.borderColor = rgba
//        tabBar.layer.borderWidth = 1
//        tabBar.layer.masksToBounds = true
        
        let homePageController = UINavigationController(rootViewController: UIViewController())
        let coinMarketController = UINavigationController(rootViewController: UIViewController())
        let addingController = UINavigationController(rootViewController: UIViewController())
        let alertsController = UINavigationController(rootViewController: UIViewController())
        let profileController = UINavigationController(rootViewController: UIViewController())
        
        homePageController.tabBarItem.image = UIImage(systemName: "briefcase")
        coinMarketController.tabBarItem.image = UIImage(systemName: "chart.bar")
        addingController.tabBarItem.image = UIImage(systemName: "plus.diamond")
        alertsController.tabBarItem.image = UIImage(systemName: "bell")
        profileController.tabBarItem.image = UIImage(systemName: "person")
        
        setViewControllers([
            homePageController,
            coinMarketController,
            addingController,
            alertsController,
            profileController
        ], animated: false)
    }
}
