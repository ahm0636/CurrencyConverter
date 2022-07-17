//
//  CryptoPriceResponse.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 14/07/22.
//

import Foundation

struct PriceResponse: Codable {
    let euro: Double
    let usd: Double
    enum CodingKeys: String, CodingKey {
        case euro = "EUR"
        case usd = "USD"
    }
}
