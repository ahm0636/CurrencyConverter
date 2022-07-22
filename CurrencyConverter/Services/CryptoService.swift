//
//  CryptoService.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 14/07/22.
//

/*
 URL:
 https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 */

import Foundation

final class CryptoService {
    static let shared = CryptoService()

    private struct Constants {
        static let apiKey = "5624573F-E6A6-46CD-B8A2-26C064B1F820"
        static let assetsEndpoint = "https://rest-sandbox.coinapi.io/v1/assets/"
        static let url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
    }


    private init() {}

    public var icons: [Icon] = []
    var data: [Crypto] = []

    private var whenReadyBlock: ((Result<[Crypto], Error>) -> Void)?
    // MARK: - Public
    public func getAllCryptoData(completion: (([Crypto]?) -> Void)?) {
        guard let url = URL(string: Constants.url) else {
            completion?(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                do {
                    guard let data = data, error == nil else {
                        completion?(nil)
                        return
                    }
                    self.data = try JSONDecoder().decode([Crypto].self, from: data)
                    completion?(self.data.sorted { first, second  in
                        first.priceUSD ?? 0 > second.priceUSD ?? 0})
                }
                catch {
                    print(error.localizedDescription)
                    completion?(nil)
                }
            }
        }
        .resume()
    }

    public func getAllIcons() {
        guard let url = URL(string: "") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                self?.icons = try JSONDecoder().decode([Icon].self, from: data)
            }
            catch {
                print(error)
            }
        }
            task.resume()
        }
    }

struct Crypto: Decodable {
    let assetID: String?
    let name: String?
    let priceUSD: Float?
    let idIcon: String?
    let symbol: String?
    let priceChangeDaily: Double?

    enum CodingKeys: String, CodingKey {
        typealias RawValue = String
        case name = "name"
        case symbol = "symbol"
        case assetID = "asset_id"
        case priceUSD = "current_price"
        case idIcon = "id_icon"
        case priceChangeDaily = "price_change_24h"

    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try? container.decode(String.self, forKey: .name)
        self.assetID = try? container.decode(String.self, forKey: .assetID)
        self.priceUSD = try? container.decode(Float.self, forKey: .priceUSD)
        self.idIcon = try? container.decode(String.self, forKey: .idIcon)
        self.symbol = try? container.decode(String.self, forKey: .symbol)
        self.priceChangeDaily = try? container.decode(Double.self, forKey: .priceChangeDaily)
    }
}

struct Icon: Codable {
    let asset_id: String
    let url: String
}


/*
 public func getAllCryptoData(completion: @escaping (Result<[Crypto], Error>) -> Void) {
     guard !icons.isEmpty else {
         whenReadyBlock = completion
         return
     }
     guard let url = URL(string: Constants.assetsEndpoint + "?apikey=" + Constants.apiKey) else {
         return
     }
     let task = URLSession.shared.dataTask(with: url) { data, _, error in
         guard let data = data, error == nil else {
             return
         }
         do {
             let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
             self.data = try JSONDecoder().decode([Crypto].self, from: data)
             completion(.success(cryptos.sorted { first, second -> Bool in
                 return first.priceUSD ?? 0 > second.priceUSD ?? 0

             }))
         }
         catch {
             completion(.failure(error))
         }
     }
     task.resume()
 }*/
