//
//  PortfolioViewController.swift
//  AlphaAltcoins
//
//  Created by Илья on 13.12.2022.
//

import UIKit

final class PortfolioViewController: UIViewController {
    
    private var activityIndicator: UIActivityIndicatorView?
    private let walletLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(PortfolioCell.self,
                       forCellReuseIdentifier: PortfolioCell.identifier)
        return table
    }()
    
    private var viewModel: PortfolioViewModelProtocol! {
        didSet {
            viewModel.fetchMarkets { [weak self] in
                self?.tableView.reloadData()
                self?.activityIndicator?.stopAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel = PortfolioViewModel()
        view.addSubview(tableView)
        tableView.rowHeight = 100
        view.backgroundColor = .systemBackground
        activityIndicator = showActivityIndicator(in: view)
        setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
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
    
    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemIndigo
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        return activityIndicator
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
