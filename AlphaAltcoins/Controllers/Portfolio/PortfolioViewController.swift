//
//  PortfolioViewController.swift
//  AlphaAltcoins
//
//  Created by Илья on 13.12.2022.
//

import UIKit

final class PortfolioViewController: UIViewController {
    
    private let walletLabel: UILabel = {
        let label = UILabel()
        label.text = "0.00$"
        return label
    }()
    
    private let activityIndicator = UIActivityIndicatorView()
    private let tableView = UITableView()
    
    private var viewModel: PortfolioViewModelProtocol! {
        didSet {
            viewModel.fetchMarkets { [weak self] in
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.colorWith(name: Resources.Colors.background)
    
        view.addSubview(walletLabel)
        viewModel = PortfolioViewModel()
        
        showActivityIndicator(in: view)
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        walletLabel.frame = view.bounds
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "My Portfolio"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = .systemBackground
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.secondaryLabel]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.secondaryLabel]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func showActivityIndicator(in view: UIView) {
        activityIndicator.style = .large
        activityIndicator.color = .systemIndigo
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    private func setupTableView() {
        tableView.register(
            PortfolioCell.self,
            forCellReuseIdentifier: PortfolioCell.identifier)
        tableView.rowHeight = 80
        setTableViewDelegates()
        view.addSubview(tableView)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    deinit {
        print("PortfolioViewController")
    }
}

// MARK: - UITableViewDataSource
extension PortfolioViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PortfolioCell.identifier, for: indexPath)
        guard let cell = cell as? PortfolioCell else { return UITableViewCell() }
        cell.viewModel = viewModel.getPortfolioCellViewModel(at: indexPath)
        return cell
    }
}
// MARK: - UITableViewDelegate
extension PortfolioViewController: UITableViewDelegate {
    
}
