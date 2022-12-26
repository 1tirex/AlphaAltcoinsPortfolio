//
//  CoinMarketViewController.swift
//  AlphaAltcoins
//
//  Created by Илья on 13.12.2022.
//

import UIKit

final class CoinMarketViewController: UIViewController {
    
    // MARK: - Private Properties
    private let activityIndicator = UIActivityIndicatorView()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let change24button = UIButton(type: .custom)
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text
        else { return false }
        
        return text.isEmpty
    }
    private var isFiltering: Bool {
        searchController.isActive && !searchBarIsEmpty
    }
    
    private var viewModel: CoinMarketViewModelProtocol! {
        didSet {
            viewModel.fetchCoins { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CoinMarketViewModel()
        
        setupUI()
    }
    
    // MARK: - @objc Func
    @objc private func showSearchTab(sender: AnyObject) {
        showSearchBarButton()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        setBackgroundColor()
        showActivityIndicator(in: view)
        setNavigationBar()
        setTableView()
        setSearchController()
        setButton()
        addSubviews(tableView, activityIndicator, change24button)
        setConstraints()
    }
    
    private func setBackgroundColor() {
        view.backgroundColor =
        UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor.colorWith(
                    name: Resources.Colors.background) ?? .systemBackground
            default:
                return UIColor.colorWith(
                    name: Resources.Colors.secondaryBackground) ?? .systemGray6
            }
        }
    }
    
    private func addSubviews(_ views: UIView...) {
        views.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func showActivityIndicator(in view: UIView) {
        activityIndicator.style = .large
        activityIndicator.color = UIColor.colorWith(name: Resources.Colors.active)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    private func setNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.colorWith(name: Resources.Colors.inActive) ?? .white
        ]
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.colorWith(name: Resources.Colors.inActive) ?? .white
        ]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationItem.title = "Coin Market"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.colorWith(name: Resources.Colors.inActive)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                            target: self,
                                                            action: #selector(showSearchTab))
    }
    
    private func showSearchBarButton() {
        if navigationController?.navigationBar.tintColor == UIColor.colorWith(name: Resources.Colors.active) {
            navigationController?.navigationBar.tintColor = UIColor.colorWith(name: Resources.Colors.inActive)
            navigationItem.searchController = nil
            searchController.searchBar.isHidden = true
            searchController.searchBar.isTranslucent = true
        } else {
            navigationController?.navigationBar.tintColor = UIColor.colorWith(name: Resources.Colors.active)
            navigationItem.searchController = searchController
            searchController.searchBar.isHidden = false
            searchController.searchBar.isTranslucent = false
            searchController.searchBar.becomeFirstResponder()
        }
    }
    
    private func setSearchController() {
        //                searchController.hidesNavigationBarDuringPresentation = true
        //                searchController.searchBar.sizeToFit()
        //        definesPresentationContext = true
        //        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.delegate = self
        searchController.searchBar.isHidden = true
        searchController.searchBar.placeholder = "BTC"
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
        }
    }
    
    private func setTableView() {
        tableView.register(
            CoinMarketCell.self,
            forCellReuseIdentifier: CoinMarketCell.identifier)
        tableView.rowHeight = 80
        tableView.tableHeaderView = UIView(frame:
                                            CGRect(x: 0,
                                                   y: 0,
                                                   width: tableView.frame.size.width,
                                                   height: 0.01)
        )
        setTableViewDelegates()
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setButton() {
        change24button.setTitle("24 Hours", for: .normal)
        change24button.setTitleColor(UIColor.colorWith(name: Resources.Colors.inActive), for: .normal)
        //        change24button.setTitleColor(UIColor.colorWith(name: Resources.Colors.active), for: .focused)
        change24button.layer.cornerRadius = 10
        change24button.backgroundColor =
        UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor.colorWith(
                    name: Resources.Colors.secondaryBackground) ?? .systemBackground
            default:
                return UIColor.colorWith(
                    name: Resources.Colors.background) ?? .systemGray6
            }
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            // Change
            change24button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            change24button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            change24button.widthAnchor.constraint(equalToConstant: 90),
            
            // Table
            tableView.topAnchor.constraint(equalTo: change24button.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                              constant: -10),
            // Indicator
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    deinit {
        print("CoinMarketViewController")
    }
    
    
    private func coinNotFounding(stutus: StutusAlert) {
        let alert = UIAlertController(
            title: stutus.title,
            message: stutus.message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension CoinMarketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        activityIndicator.isAnimating ? 0 : viewModel.numberOfRows(for: isFiltering)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinMarketCell.identifier,
                                                 for: indexPath)
        guard let cell = cell as? CoinMarketCell else { return UITableViewCell() }
        cell.viewModel = viewModel.getCoinMarketViewModel(at: indexPath, for: isFiltering)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CoinMarketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //        let selectCoin = isFiltering
        //        ? filteredMarket[indexPath.row]
        //        : markets[indexPath.row]
        //        performSegue(withIdentifier: "addCoin", sender: selectCoin)
    }
}

// MARK: - UISearchBarDelegate
extension CoinMarketViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        showSearchBarButton()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        if text.isEmpty {
            activityIndicator.stopAnimating()
            tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text is \(searchText)", isFiltering)
        
        if !searchText.trimmingCharacters(in: .whitespaces).isEmpty,
           searchText.trimmingCharacters(in: .whitespaces).count >= 2 {
            
            activityIndicator.startAnimating()
            tableView.reloadData()
            
            viewModel.fetchSearch(from: searchText) { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
    }
}
