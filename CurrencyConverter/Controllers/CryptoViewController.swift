//
//  CryptoControllerViewController.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 14/07/22.
//

import UIKit

class CryptoViewController: UIViewController {

    // MARK: - ATTRIBUTES
    private var viewModels = [CryptoTableViewCellViewModel]()

    var list: [Crypto] = []
    var displayedCrypto: [Crypto] = []

    lazy var searchBar2: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width - 50, height: 20))
    let searchController = UISearchController(searchResultsController: nil)
    var isSearching = false

    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        formatter.numberStyle = .currency
        formatter.formatterBehavior = .default
        return formatter
    }()

    // MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Crypto"

        tableView.allowsSelection = false
        searchBar2 = searchController.searchBar
        searchBar2.delegate = self

        navigationItem.searchController = searchController
        CryptoService.shared.getAllCryptoData { [weak self] data in
            guard let self = self, let data = data else { return }

            self.list = data
            self.displayedCrypto = self.list
            print(self.list)
//            self.viewModels = self.list as! [CryptoTableViewCellViewModel]

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }
}

extension CryptoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayedCrypto.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cryptoCell") as! UpdatedCryptoTableViewCell
        cell.data = displayedCrypto[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

}

extension CryptoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateFilteredResult(searchText: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar2 = searchBar
        searchBar2.text = ""
        tableView.reloadData()
    }

    func updateFilteredResult(searchText: String) {
        searchBar2.text = searchText
        guard !searchBar2.text!.isEmpty else {
            displayedCrypto = CryptoService.shared.data
            tableView.reloadData()
            return
        }

        let filteredCurrencies = list.filter { $0.name!.lowercased().contains(searchBar2.text!.lowercased()) }
        displayedCrypto = filteredCurrencies
        isSearching = true
        tableView.reloadData()
    }
}
