//
//  CoinMarketViewController.swift
//  AlphaAltcoins
//
//  Created by Илья on 13.12.2022.
//

import UIKit

class CoinMarketViewController: UIViewController {
    
    private let activityIndicator = UIActivityIndicatorView()
    private let tableView =
    UITableView(frame: .zero,
                style: .insetGrouped)
    
    private let searchController =
    UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text
        else {
            return false
        }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CoinMarketViewModel()
        
        setupUI()
        addSubviews(tableView, activityIndicator)
        showActivityIndicator(in: view)
        setConstraints()
    }
    
    private func setupUI() {
        setBackgroundColor()
        setNavigationBar()
        setTableView()
        setSearchController()
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
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = UIColor.colorWith(name: Resources.Colors.inActive)
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem: .search,
                        target: self,
                        action: #selector(showSearchTab))
    }
    
    @objc private func showSearchTab(sender: AnyObject) {
        showSearchBarButton()
    }
    
    private func showSearchBarButton() {
        if navigationController?.navigationBar.tintColor == UIColor.colorWith(name: Resources.Colors.active) {
            navigationController?.navigationBar.tintColor = UIColor.colorWith(name: Resources.Colors.inActive)
            searchController.searchBar.isHidden = true
        } else {
            navigationController?.navigationBar.tintColor = UIColor.colorWith(name: Resources.Colors.active)
            searchController.searchBar.isHidden = false
            searchController.searchBar.becomeFirstResponder()
        }
    }
    
    private func setSearchController() {
        //        searchController.hidesNavigationBarDuringPresentation = true
        //        searchController.searchBar.sizeToFit()
        //        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.isHidden = true
        searchController.searchBar.placeholder = "BTC"
        definesPresentationContext = true
        
        if let textField =
            searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
        }
    }
    
    private func setTableView() {
        tableView.register(
            CoinMarketCell.self,
            forCellReuseIdentifier: CoinMarketCell.identifier)
        tableView.rowHeight = 80
        setTableViewDelegates()
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                              constant: -10),
            
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
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
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        activityIndicator.isAnimating ? 0 : viewModel.numberOfRows(for: isFiltering)
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        activityIndicator.startAnimating()
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }

        if text.isEmpty {
            activityIndicator.stopAnimating()
//            coinNotFounding(stutus: .failed)
            tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text is \(searchText)", isFiltering)
        activityIndicator.startAnimating()
        tableView.reloadData()
        
        if !searchText.trimmingCharacters(in: .whitespaces).isEmpty,
           searchText.trimmingCharacters(in: .whitespaces).count >= 2 {
            
            viewModel.fetchSearch(from: searchText) { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        } else {
            activityIndicator.stopAnimating()
//            coinNotFounding(stutus: .failed)
            tableView.reloadData()
        }
    }
}
