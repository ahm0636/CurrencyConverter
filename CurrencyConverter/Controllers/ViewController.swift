//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 17/06/22.
//

import UIKit
import DropDown

class ViewController: UIViewController {

    // MARK: - ATTRIBUTES
    var list = [Currencyy]()
    let date = Date()
    let searchController = UISearchController(searchResultsController: nil)

    lazy var searchBar2: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width - 50, height: 20))

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
    var check1: Bool = false
    var check2: Bool = false
    var itemSelected = 0
    var itemSelected2 = 1
    var amount: String = ""

    var isSearching = false
    // MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!

    @IBOutlet weak var currencyChangeView2: UIView!
    @IBOutlet weak var currencyChangeView: UIView!
    @IBOutlet weak var dropDownListView: UIView!

    @IBOutlet weak var dropDownListView2: UIView!


    @IBOutlet weak var currencyLabel2: UILabel!
    @IBOutlet weak var currentCurrencyLabel: UILabel!
    @IBOutlet weak var currentCurrencyImage: UIImageView!
    @IBOutlet weak var currencyImage2: UIImageView!

    @IBOutlet weak var changeCurButton: UIButton!
    // MARK: - ACTIONS
    @IBAction func changeButton(_ sender: Any) {
        revertCurrencies(mainImg: currentCurrencyImage.image,
                         mainCur: secondTextField.text,
                         text: currentCurrencyLabel.text,
                         changeView: currencyChangeView2)

        let test = Double(round(1000 * exchange(secondTextField.text?.toDouble() ?? 0.0, from: list[itemSelected2], to: list[itemSelected])!.doubleValue) / 1000)
        firstTextField.text = String(test)

        let test2 = Double(round(1000 * exchange(firstTextField.text?.toDouble() ?? 0.0, from: list[itemSelected], to: list[itemSelected2])!.doubleValue) / 1000)
        secondTextField.text = String(test2)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar2 = searchController.searchBar
        searchBar2.delegate = self

        navigationItem.searchController = searchController
        self.title = "Converter"

        secondTextField.keyboardType = UIKeyboardType.decimalPad

        // show date
        dateLabel.text = ("\(date.get(.day)).\(date.get(.month)).\(date.get(.year))")

        changeCurButton.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        let viewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeCurrencyTapped))
        viewGestureRecognizer.delegate = self

        let viewGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(changeCurrencyTapped2))
        viewGestureRecognizer2.delegate = self

        CurrencyService.shared.fetchData { [weak self] data in
            guard let self = self, let data = data else { return }
            self.list = data
            self.displayedCurrencies = self.list
            DispatchQueue.main.async {
                self.changeCurButton.isHidden = true
                self.firstTextField.text = self.exchange(self.secondTextField.text?.toDouble() ?? 0.0, from: self.list[self.itemSelected2], to: self.list[1])
                self.secondTextField.text = self.exchange(self.firstTextField.text?.toDouble() ?? 0.0, from: self.list[1], to: self.list[0])
                self.tableView.reloadData()
            }
        }


        secondTextField.addTarget(self, action: #selector(textFieldDidEditingChange), for: .editingChanged)
        firstTextField.addTarget(self, action: #selector(textFieldDidEditingChange2), for: .editingChanged)
        amount = secondTextField.text ?? ""

        currencyChangeView.addGestureRecognizer(viewGestureRecognizer)
        currencyChangeView2.addGestureRecognizer(viewGestureRecognizer2)

        currencyDropDown()

    }

    @objc func textFieldDidEditingChange() {
        //    firstTextField.text = exchange(secondTextField.text?.toDouble() ?? 0.0, from: list[itemSelected2], to: list[itemSelected])
        let test = Double(round(1000 * exchange(secondTextField.text?.toDouble() ?? 0.0, from: list[itemSelected2], to: list[itemSelected])!.doubleValue) / 1000)
        firstTextField.text = String(test)
    }

    @objc func textFieldDidEditingChange2() {
        //  secondTextField.text = exchange(firstTextField.text?.toDouble() ?? 0.0, from: list[itemSelected], to: list[itemSelected2])
        let test = Double(round(1000 * exchange(firstTextField.text?.toDouble() ?? 0.0, from: list[itemSelected], to: list[itemSelected2])!.doubleValue) / 1000)
        secondTextField.text = String(test)
    }

    // MARK: - CUSTOM FUNCTIONS
    func defaultValue() {
        let testt = exchange(firstTextField.text?.toDouble() ?? 0, from: displayedCurrencies[1], to: displayedCurrencies[2])
        secondTextField.text = testt
    }

    func currencyDropDown() {
        // currency choose (dropDown)
        dropDown.anchorView = dropDownListView2
        dropDown.dataSource = dropDownValue

        dropDown2.anchorView = dropDownListView
        dropDown2.dataSource = dropDownValue

        if unabledTextField {
            dropDown.dismissMode = .automatic
        }

        // dropDown for the second textField
        dropDown.width = 90
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item \(item) at index: \(index)")
            itemSelected = index
            print(itemSelected)
            check1 = true
//            if check1 && check2 {
//                changeCurButton.isHidden = false
//            }
            self.currentCurrencyLabel.text = dropDownValue[index]
            self.currentCurrencyImage.image = UIImage(named: dropDownValue[index])
            // recalculate
            let test = Double(round(1000 * exchange(secondTextField.text?.toDouble() ?? 0.0, from: list[itemSelected2], to: list[itemSelected])!.doubleValue) / 1000)
            firstTextField.text = String(test)
            //            firstTextField.text = exchange(secondTextField.text?.toDouble() ?? 0.0, from: list[itemSelected2], to: list[itemSelected])
        }

        // dropDown for the first textField
        dropDown2.width = 90
        dropDown.backgroundColor = .white

        dropDown2.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item \(item) at index: \(index)")
            itemSelected2 = index
            check2 = true
//            if check1 && check2 == true {
//                changeCurButton.isHidden = false
//            }
            self.currencyLabel2.text = dropDownValue[index]
            self.currencyImage2.image = UIImage(named: dropDownValue[index])
            // recalculate
            let test = Double(round(1000 * exchange(firstTextField.text?.toDouble() ?? 0.0, from: list[itemSelected], to: list[itemSelected2])!.doubleValue) / 1000)
            secondTextField.text = String(test)
            //            secondTextField.text = exchange(firstTextField.text?.toDouble() ?? 0.0, from: list[itemSelected], to: list[itemSelected2])
        }

        dropDown.cellNib = UINib(nibName: "MyDropDownCell", bundle: nil)
        dropDown.customCellConfiguration = { index, title, cell in
            guard let cell = cell as? MyDropDownCell else {
                return
            }
            cell.flagImageView?.image = UIImage(named: "\(self.dropDownValue[index])") ?? nil
            cell.name.text = self.dropDownValue[index]
        }



        dropDown2.cellNib = UINib(nibName: "MyDropDownCell", bundle: nil)
        dropDown2.customCellConfiguration = { index, title, cell in
            guard let cell = cell as? MyDropDownCell else {
                return
            }
            cell.flagImageView?.image = UIImage(named: "\(self.dropDownValue[index])") ?? nil
            cell.name.text = self.dropDownValue[index]
        }

    }

    func exchange(_ amount: Double, from: Currencyy, to: Currencyy) -> String? {
        guard let fromRate = from.rate, let toRate = to.rate else {
            return nil
        }
        guard from.ccy != "UZS" else {
            return String(fromRate.doubleValue * amount)
        }

        guard to.ccy != "UZS" else {
            return String(toRate.doubleValue * amount)
        }

        let fromValue = fromRate.doubleValue
        let toValue = toRate.doubleValue

        let diff = abs((toValue - fromValue) / fromValue)
        var coef: Double = 1
        if fromValue > toValue {
            coef = 1 - diff
        } else {
            coef = 1 + diff
        }
        let result = String(amount * coef)
        return result
    }

    func revertCurrencies(mainImg: UIImage?,
                          mainCur: String?,
                          text: String?,
                          changeView: UIView?) {
        currencyChangeView.self = currencyChangeView2
        currentCurrencyImage.image = currencyImage2.image
        secondTextField.text = firstTextField.text
        currentCurrencyLabel.text = currencyLabel2.text
        currencyImage2.image = mainImg
        firstTextField.text = mainCur
        currencyLabel2.text = text
        currencyChangeView2.self = changeView
    }

    @objc func changeCurrencyTapped() {
        dropDown.show()
    }
    @objc func changeCurrencyTapped2() {
        dropDown2.show()
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayedCurrencies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CurrencyTableViewCell
        let value = displayedCurrencies[indexPath.row]
        cell.data = value
        return cell
    }


}

extension ViewController: UIGestureRecognizerDelegate {

}

extension ViewController: UISearchBarDelegate {
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
            displayedCurrencies = CurrencyService.shared.data
            tableView.reloadData()
            return
        }

        let filteredCurrencies = list.filter { $0.ccy!.lowercased().contains(searchBar2.text!.lowercased()) }
        displayedCurrencies = filteredCurrencies
        isSearching = true
        tableView.reloadData()
    }

}


