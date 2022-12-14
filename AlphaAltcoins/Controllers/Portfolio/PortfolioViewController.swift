//
//  PortfolioViewController.swift
//  AlphaAltcoins
//
//  Created by Илья on 13.12.2022.
//

import UIKit

final class PortfolioViewController: UIViewController {
    
    private let walletLabel = UILabel()
    private let profitWalletLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
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
        viewModel = PortfolioViewModel()
        configure()
    }
    
    //    override func viewDidLayoutSubviews() {
    //        super.viewDidLayoutSubviews()
    //    }
    
    private func configure() {
        setBackgroundColor()
        addSubviews(activityIndicator, walletLabel, profitWalletLabel, tableView)
        showActivityIndicator(in: view)
        setupNavigationBar()
        setConstraints()
        setupTableView()
    }
    
    private func addSubviews(_ views: UIView...) {
        views.forEach { view.addSubview($0) }
    }
    
    private func setBackgroundColor() {
        view.backgroundColor =
        UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor.colorWith(name: Resources.Colors.background)
                ?? .systemBackground
            default:
                return UIColor.colorWith(name: Resources.Colors.secondaryBackground)
                ?? .systemGray6
            }
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "My Portfolio"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = .clear
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
    }
    
    private func setupTableView() {
        tableView.register(
            PortfolioCell.self,
            forCellReuseIdentifier: PortfolioCell.identifier)
        tableView.rowHeight = 80
        setTableViewDelegates()
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setLabel(for label: UILabel,
                          with text: String,
                          size: Double,
                          color: UIColor?) {
        
        label.text = text
        label.textColor = color
        label.numberOfLines = 1
        label.font = UIFont.helvelticaRegular(with: size)
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        setLabel(for: walletLabel,
                 with: viewModel.walletLabel,
                 size: 40,
                 color: UIColor.colorWith(name: Resources.Colors.active))
        walletLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                         constant: 20).isActive = true
        walletLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                             constant: 25).isActive = true
        
        setLabel(
            for: profitWalletLabel,
            with: "0.00$",
            size: 20,
            color: UIColor.colorWith(name: Resources.Colors.inActive))
        profitWalletLabel.topAnchor.constraint(equalTo: walletLabel.bottomAnchor,
                                               constant: 5).isActive = true
        profitWalletLabel.leadingAnchor.constraint(equalTo: walletLabel.leadingAnchor).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: profitWalletLabel.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
