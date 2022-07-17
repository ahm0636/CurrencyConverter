//
//  CurrencyBrain.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 04/07/22.
//

import Foundation
import UIKit

struct CurrencyBrain {

    let usLocale = Locale(identifier: "en_US")
    let frenchLocale = Locale(identifier: "fr_FR")
    let germanLocale = Locale(identifier: "de_DE")
    let hungarianLocale = Locale(identifier: "hu_HU")
    let hungarianLocalee = Locale(identifier: "it_IT")

    func convertDoubleToCurrency(amount: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        return numberFormatter.string(from: NSNumber(value: amount))!
    }
    func convertCurrencyToDouble(input: String) -> Double? {
         let numberFormatter = NumberFormatter()
         numberFormatter.numberStyle = .currency
         numberFormatter.locale = Locale.current
         return numberFormatter.number(from: input)?.doubleValue
    }

    var typedValue: Int = 0

    func typedValueToCurrency() -> String? {
          let numberFormatter = NumberFormatter()
          numberFormatter.numberStyle = .currency
          numberFormatter.locale = Locale.current
          let amount = Double(typedValue/100) +
                       Double(typedValue%100)/100
          return numberFormatter.string(from: NSNumber(value: amount))!
    }


//    func textField(_ textFieldToChange: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//      if textFieldToChange == typedValueTextField {
//        if let digit = Int(string) {
//           typedValue = typedValue * 10 + digit
//           totalAmount.text = typedValueToCurrency()
//        }
//        if string == "" {
//           typedValue = typedValue /10
//           totalAmount.text = typedValueToCurrency()
//        }
//      } else if textFieldToChange == textFieldnotInCurrency {
//           return true
//      }
//      return false
//    }


    // main convert function
   /* func convert(_ convert: String) -> String {
        let euroRates = ["USD": 1.15, "EUR": 1.0, "GBP": 0.84, "UZS": 0.02, "TL": 0.2]
        let usdRates = ["USD": 1.0, "EUR": 1.0, "GBP": 0.73, "UZS": 0.03, "TL": 0.4]
        let gbpRates = ["USD": 1.37, "EUR": 1.10, "GBP": 1.0, "UZS": 0.01, "TL": 0.5]
        let uzsRates = ["USD": 0.05, "EUR": 0.02, "GBP": 0.01, "UZS": 0.02, "TL": 0.9]
        let tlRates = ["USD": 0.1, "EUR": 0.09, "GBP": 0.07, "UZS": 0.7, "TL": 1.0]

        var conversion: Double = 1.0
        let amount = Double(convert.doubleValue)
        let selectedCurrency = dropDownValue[itemSelected]
        let to = dropDownValue[itemSelected2]
//        let selectedCurrencies = displayedCurrencies[itemSelected]
//        let id = selectedCurrencies.id
//        let to = displayedCurrencies[itemSelected2]
//        let test: Double = displayedCurrencies[itemSelected2].rate!.toDouble() ?? 0.0

        switch (selectedCurrency) {
        case "USD":
           // conversion = "\(amount * (selectedCurrencies.rate![to] ?? ""))"
            conversion = amount * (usdRates[to] ?? 0.0)
            print("0")
        case "EUR":
            conversion = amount * (euroRates[to] ?? 0.0)
            print("1")
        case "GBP":
            conversion = amount * (gbpRates[to] ?? 0.0)
            print("2")
        case "UZS":
            conversion = amount * (uzsRates[to] ?? 0.0)
        case "TL":
            conversion = amount * (tlRates[to] ?? 0.0)
        default:
            print("Something went wrong")
        }
        return String(format: "%.2f", conversion)

    } */

}
