//
//  MainTableViewCell.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 13/07/22.
//

import UIKit
import DropDown

class MainTableViewCell: UITableViewCell {
    var list = [Currencyy]()
    var displayedCurrencies: [Currencyy] = []

    let dropDown = DropDown()
    let dropDown2 = DropDown()
    var itemSelected = 0
    var itemSelected2 = 1
    
    let dropDownValue = ["USD", "EUR", "RUB", "GBP", "JPY", "AZN", "BDT", "BGN", "BHD", "BND", "BRL", "BYN", "CAD", "CHF",
                         "CNY", "CUP", "CZK", "DKK", "DZD", "EGP", "AFN", "ARS", "GEL", "HKD", "HUF", "IDR", "ILS", "INR", "IQD", "IRR", "ISK",
                         "JOD", "AUD", "KGS", "KHR", "KRW", "KWD", "KZT", "LAK", "LBP", "LYD", "MAD", "MDL", "MMK", "MNT", "MXN", "MYR", "NOK",
                         "NZD", "OMR", "PHP", "PKR", "PLN", "QAR", "RON", "RSD", "AMD", "SAR", "SDG", "SEK", "SGD", "SYP", "THB", "TJS", "TMT",
                         "TND", "TRY", "UAH", "AED", "UYU", "VES", "VND", "XDR", "YER", "ZAR"]

    let dropDownImages = ["USD", "EUR", "RUB", "GBP", "JPY", "AZN", "BDT", "BGN", "BHD", "BND", "BRL", "BYN", "CAD", "CHF",
                          "CNY", "CUP", "CZK", "DKK", "DZD", "EGP", "AFN", "ARS", "GEL", "HKD", "HUF", "IDR", "ILS", "INR", "IQD", "IRR", "ISK",
                          "JOD", "AUD", "KGS", "KHR", "KRW", "KWD", "KZT", "LAK", "LBP", "LYD", "MAD", "MDL", "MMK", "MNT", "MXN", "MYR", "NOK",
                          "NZD", "OMR", "PHP", "PKR", "PLN", "QAR", "RON", "RSD", "AMD", "SAR", "SDG", "SEK", "SGD", "SYP", "THB", "TJS", "TMT",
                          "TND", "TRY", "UAH", "AED", "UYU", "VES", "VND", "XDR", "YER", "ZAR"]

    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!

    @IBOutlet weak var currencyChangeView2: UIView!
    @IBOutlet weak var currencyChangeView: UIView!
    @IBOutlet weak var dropDownListView: UIView!

    @IBOutlet weak var currencyLabel2: UILabel!
    @IBOutlet weak var currentCurrencyLabel: UILabel!
    @IBOutlet weak var currentCurrencyImage: UIImageView!
    @IBOutlet weak var currencyImage2: UIImageView!

    @IBOutlet weak var changeCurButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        let viewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeCurrencyTapped))
        viewGestureRecognizer.delegate = self

        let viewGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(changeCurrencyTapped2))
        viewGestureRecognizer2.delegate = self
        
        secondTextField.keyboardType = UIKeyboardType.decimalPad
        secondTextField.addTarget(self, action: #selector(textFieldDidEditingChange), for: .editingChanged)
        firstTextField.addTarget(self, action: #selector(textFieldDidEditingChange2), for: .editingChanged)
        
        CurrencyService.shared.fetchData { [weak self] data in
            guard let self = self, let data = data else { return }
            self.list = data
            self.displayedCurrencies = self.list
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
        }
        currencyDropDown()
        changeCurButton.addTarget(self, action: #selector(changeCurrency), for: .touchUpInside)
        // Initialization code
    }
    
    @objc func textFieldDidEditingChange() {
        //    firstTextField.text = exchange(secondTextField.text?.toDouble() ?? 0.0, from: list[itemSelected2], to: list[itemSelected])
        let test = Double(round(100 * exchange(secondTextField.text?.toDouble() ?? 0.0, from: list[itemSelected2], to: list[itemSelected])!.doubleValue) / 100)
        firstTextField.text = String(test)
    }
    @objc func textFieldDidEditingChange2() {
        //  secondTextField.text = exchange(firstTextField.text?.toDouble() ?? 0.0, from: list[itemSelected], to: list[itemSelected2])
        let test = Double(round(100 * exchange(firstTextField.text?.toDouble() ?? 0.0, from: list[itemSelected], to: list[itemSelected2])!.doubleValue) / 100)
        secondTextField.text = String(test)
    }

    @objc func changeCurrency(sender: UIButton)  {
        revertCurrencies(mainImg: currentCurrencyImage.image,
                         mainCur: secondTextField.text,
                         text: currentCurrencyLabel.text,
                         changeView: currencyChangeView2)
    }

    @objc func changeCurrencyTapped() {
        dropDown.show()
    }
    @objc func changeCurrencyTapped2() {
        dropDown2.show()
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

    func currencyDropDown() {
        // currency choose (dropDown)

        dropDown.anchorView = dropDownListView
        dropDown.dataSource = dropDownValue

        dropDown2.anchorView = dropDownListView
        dropDown2.dataSource = dropDownValue

        // dropDown for the second textField
        dropDown.width = 150
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item \(item) at index: \(index)")
            itemSelected = index
            print(itemSelected)
            self.currentCurrencyLabel.text = dropDownValue[index]
            self.currentCurrencyImage.image = UIImage(named: dropDownValue[index])
            // recalculate
            let test = Double(round(100 * exchange(secondTextField.text?.toDouble() ?? 0.0, from: list[itemSelected2], to: list[itemSelected])!.doubleValue) / 100)
            firstTextField.text = String(test)
            //            firstTextField.text = exchange(secondTextField.text?.toDouble() ?? 0.0, from: list[itemSelected2], to: list[itemSelected])
        }

        // dropDown for the first textField
        dropDown2.width = 150
        dropDown2.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item \(item) at index: \(index)")
            itemSelected2 = index
            self.currencyLabel2.text = dropDownValue[index]
            self.currencyImage2.image = UIImage(named: dropDownValue[index])
            // recalculate
            let test = Double(round(100 * exchange(firstTextField.text?.toDouble() ?? 0.0, from: list[itemSelected], to: list[itemSelected2])!.doubleValue) / 100)
            secondTextField.text = String(test)
            //            secondTextField.text = exchange(firstTextField.text?.toDouble() ?? 0.0, from: list[itemSelected], to: list[itemSelected2])
        }

        dropDown.cellNib = UINib(nibName: "MyDropDownCell", bundle: nil)
        dropDown.customCellConfiguration = { index, title, cell in
            guard let cell = cell as? MyDropDownCell else {
                return
            }
            cell.flagImageView?.image = UIImage(named: "\(self.dropDownValue[index])") ?? nil
        }

        dropDown2.cellNib = UINib(nibName: "MyDropDownCell", bundle: nil)
        dropDown2.customCellConfiguration = { index, title, cell in
            guard let cell = cell as? MyDropDownCell else {
                return
            }
            cell.flagImageView?.image = UIImage(named: "\(self.dropDownValue[index])") ?? nil
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

        let diff = ((toValue - fromValue) / fromValue) * (-1)
        var coef: Double = 1
        if fromValue > toValue {
            coef = 1 - diff
        } else {
            coef = 1 + diff
        }
        let result = String(amount * coef)
        //        let test = String(Double(1000 * result.doubleValue) / 1000)
        return result
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
