//
//  Settings.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 04/07/22.
//

import Foundation

class GlobalSettings {
    static let shared = GlobalSettings()

    // Rates Exchange API key [YOUR_API_KEY]
    let ratesExchangeApiKey = "https://cbu.uz/uz/arkhiv-kursov-valyut/json/"
}


struct Routes {
    private static let s = GlobalSettings.shared

    static let apiBaseUrl = "https://api.ratesexchange.eu/client"
    static let apiCheckOnLine = "\(apiBaseUrl)/checkapi"
    static let apiKeyParam = "?apiKey=\(s.ratesExchangeApiKey)"
    static let latestDetailedRatesUri = "\(apiBaseUrl)/latestdetails\(apiKeyParam)"
    static let currenciesUri = "\(apiBaseUrl)/currencies\(apiKeyParam)"
    static let convertRatesUri = "\(apiBaseUrl)/convertdetails\(apiKeyParam)"
    static let currencyHistoryRatesUri = "\(apiBaseUrl)/historydates\(apiKeyParam)"
    static let historyRatesForCurrency = "\(apiBaseUrl)/historydetails\(apiKeyParam)"
}

