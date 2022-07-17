//
//  Utils.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 06/07/22.
//

import Foundation

extension String {
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result = String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }

    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
