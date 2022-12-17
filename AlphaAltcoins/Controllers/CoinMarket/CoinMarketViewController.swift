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
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CoinMarketViewModel()
        
        setupUI()
        addSubviews(tableView)
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
                    name: Resources.Colors.background)
                ?? .systemBackground
            default:
                return UIColor.colorWith(
                    name: Resources.Colors.secondaryBackground)
                ?? .systemGray6
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
        view.addSubview(activityIndicator)
        activityIndicator.style = .large
        activityIndicator.color = UIColor.colorWith(name: Resources.Colors.active)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Coin Market"
        navigationController?.navigationBar.isTranslucent = false
        
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
        
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem: .search,
                        target: self,
                        action: #selector(showSearchTab))
        showSearchBarButton(shouldShow: true)
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationController?.navigationBar.tintColor = UIColor.colorWith(name: Resources.Colors.active)
            searchController.searchBar.isHidden = false
        } else {
            navigationController?.navigationBar.tintColor = UIColor.colorWith(name: Resources.Colors.inActive)
            searchController.searchBar.isHidden = true
        }
    }
    
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
//        searchController.searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchController.searchBar : nil
    }
    
    private func setSearchController() {
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
        
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        self.searchController.searchBar.placeholder = "BTC"
        self.searchController.searchBar.barTintColor = .white
        searchController.searchBar.isHidden = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
    
    @objc private func showSearchTab(sender: AnyObject) {
        searchController.becomeFirstResponder()
        search(shouldShow: true)
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
            tableView.topAnchor.constraint(equalTo: view.topAnchor,
                                           constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                              constant: -10)
        ])
    }
    
   
    
    deinit {
        print("CoinMarketViewController")
    }
}

// MARK: - UITableViewDataSource
extension CoinMarketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
//        isFiltering ? filteredMarket.count : viewModel.numberOfRows()
        viewModel.numberOfRows(for: isFiltering)
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinMarketCell.identifier,
                                                 for: indexPath)
        guard let cell = cell as? CoinMarketCell else { return UITableViewCell() }
//        let coinOnMarket = isFiltering
//        ? viewModel.getCoinMarketViewModel(at: indexPath)
//        //filteredMarket[indexPath.row].symbol
//        : viewModel.getCoinMarketViewModel(at: indexPath)
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

// MARK: - UISearchResultsUpdating
extension CoinMarketViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 2 else {
                  return
              }
        
        activityIndicator.startAnimating()
        viewModel.fetchSearch(from: query) { [weak self] in
            self?.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
//        fetchSearch(
//        fetchSearch(from: query)
    }
}

extension CoinMarketViewController: UISearchBarDelegate {
    
}
