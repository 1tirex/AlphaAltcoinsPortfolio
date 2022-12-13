//
//  AlertsViewController.swift
//  AlphaAltcoins
//
//  Created by Илья on 13.12.2022.
//

import UIKit

class AlertsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
    }
    private func setupNavigationBar() {
        self.navigationItem.title = "Alerts"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = .systemBackground
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.secondaryLabel]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.secondaryLabel]
        
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    deinit {
        print("AlertsViewController")
    }
}
