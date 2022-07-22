//
//  UpdatedViewController.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 13/07/22.
//

import UIKit
import DropDown

class UpdatedViewController: UIViewController {


    // MARK: - ATTRIBUTES
    var list = [Currencyy]()
    let date = Date()
    lazy var searchBar2: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20))

    var displayedCurrencies: [Currencyy] = []

    let dropDown = DropDown()
    let dropDown2 = DropDown()
    let dropDownValue = ["USD", "EUR", "RUB", "GBP", "JPY", "AZN", "BDT", "BGN", "BHD", "BND", "BRL", "BYN", "CAD", "CHF",
                         "CNY", "CUP", "CZK", "DKK", "DZD", "EGP", "AFN", "ARS", "GEL", "HKD", "HUF", "IDR", "ILS", "INR", "IQD", "IRR", "ISK",
                         "JOD", "AUD", "KGS", "KHR", "KRW", "KWD", "KZT", "LAK", "LBP", "LYD", "MAD", "MDL", "MMK", "MNT", "MXN", "MYR", "NOK",
                         "NZD", "OMR", "PHP", "PKR", "PLN", "QAR", "RON", "RSD", "AMD", "SAR", "SDG", "SEK", "SGD", "SYP", "THB", "TJS", "TMT",
                         "TND", "TRY", "UAH", "AED", "UYU", "VES", "VND", "XDR", "YER", "ZAR"]
    var currencyTypess: [String] = []

    let dropDownImages = ["USD", "EUR", "RUB", "GBP", "JPY", "AZN", "BDT", "BGN", "BHD", "BND", "BRL", "BYN", "CAD", "CHF",
                          "CNY", "CUP", "CZK", "DKK", "DZD", "EGP", "AFN", "ARS", "GEL", "HKD", "HUF", "IDR", "ILS", "INR", "IQD", "IRR", "ISK",
                          "JOD", "AUD", "KGS", "KHR", "KRW", "KWD", "KZT", "LAK", "LBP", "LYD", "MAD", "MDL", "MMK", "MNT", "MXN", "MYR", "NOK",
                          "NZD", "OMR", "PHP", "PKR", "PLN", "QAR", "RON", "RSD", "AMD", "SAR", "SDG", "SEK", "SGD", "SYP", "THB", "TJS", "TMT",
                          "TND", "TRY", "UAH", "AED", "UYU", "VES", "VND", "XDR", "YER", "ZAR"]

    var unabledTextField: Bool = true
    var itemSelected = 0
    var itemSelected2 = 1
    var amount: String = ""
    
    var isSearching = false

    // MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Didload
    override func viewDidLoad() {
        super.viewDidLoad()

        CurrencyService.shared.fetchData { [weak self] data in
            guard let self = self, let data = data else { return }
            self.list = data
       //     self.currencyTypess = data.compactMap { $0.ccy }
            self.displayedCurrencies = self.list
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }


}

extension UpdatedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        } else if indexPath.section == 1 {
            return 70
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return displayedCurrencies.count
        default:
            return 1
        }

    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainTableViewCell

            return cell2
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as! UpdatedCurrencyTableViewCell
            let value = displayedCurrencies[indexPath.row]
            cell.valueLabel.text = value.rate
            cell.currencyImage.image = UIImage(named: value.ccy!)
            return cell
        }
        return UITableViewCell()
    }

}

extension UpdatedViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateFilteredResult(searchText: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }

    func updateFilteredResult(searchText: String) {

        guard !searchText.isEmpty else {
            displayedCurrencies = CurrencyService.shared.data
            tableView.reloadData()
            return
        }

        let filteredCurrencies = list.filter { $0.ccy!.lowercased().contains(searchText.lowercased()) }
        displayedCurrencies = filteredCurrencies
        isSearching = true
        tableView.reloadData()
    }

}
