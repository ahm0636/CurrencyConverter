//
//  ConversionData.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 04/07/22.
//

import Foundation

struct ConversionData {
    var fromCurrency: String?
    var toCurrency: String?
    var fromAmount: Double?
}

struct ConversionDetails {
    var source: String?
    var amount: String?
}

struct ConversionCurrencyData {
    var currency: Currency?
    var details: ConversionDetails?
}

