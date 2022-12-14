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
//        tabBar.tintColor = UIColor.colorWith(name: Resources.Colors.active)
//        tabBar.unselectedItemTintColor = UIColor.colorWith(name: Resources.Colors.inActive)
        
        let portfolioController = generateVC(
            viewControler: PortfolioViewController(),
            image: UIImage(systemName: "briefcase"))
        let coinMarketController = generateVC(
            viewControler: CoinMarketViewController(),
            image: UIImage(systemName: "chart.bar"))
        let plusController = generateVC(
            viewControler: PlusViewController(),
            image: UIImage(systemName: "plus.diamond"))
        let alertsController = generateVC(
            viewControler: AlertsViewController(),
            image: UIImage(systemName: "bell.badge"))
        let profileController = generateVC(
            viewControler: ProfileViewController(),
            image: UIImage(systemName: "person"))
        
        setViewControllers([
            portfolioController,
            coinMarketController,
            plusController,
            alertsController,
            profileController
        ], animated: false)
    }
    
    private func generateVC(
        viewControler: UIViewController,
        image: UIImage?) -> UIViewController {
            let VC = UINavigationController(rootViewController: viewControler)
            VC.tabBarItem.image = image
            return VC
        }
}
