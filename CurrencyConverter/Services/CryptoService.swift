//
//  CryptoService.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 14/07/22.
//

import Foundation

final class CryptoService {
    static let shared = CryptoService()

    private struct Constants {
        static let apiKey = "5624573F-E6A6-46CD-B8A2-26C064B1F820"
        static let assetsEndpoint = "https://rest-sandbox.coinapi.io/v1/assets/"
    }

    private init() {}

    public var icons: [Icon] = []
    var data: [Crypto] = []

    private var whenReadyBlock: ((Result<[Crypto], Error>) -> Void)?
    // MARK: - Public
    public func getAllCryptoData(completion: (([Crypto]?) -> Void)?) {
//        guard !icons.isEmpty else {
//            whenReadyBlock = completion
//            return
//        }
        guard let url = URL(string: Constants.assetsEndpoint + "?apikey=" + Constants.apiKey) else {
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

                    let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
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
//                if let completion = self?.whenReadyBlock {
//                    self?.getAllCryptoData(completion: completion)
//                }
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


    enum CodingKeys: String, CodingKey {
        typealias RawValue = String
        case name = "name"
        case assetID = "asset_id"
        case priceUSD = "price_usd"
        case idIcon = "id_icon"

    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try? container.decode(String.self, forKey: .name)
        self.assetID = try? container.decode(String.self, forKey: .assetID)
        self.priceUSD = try? container.decode(Float.self, forKey: .priceUSD)
        self.idIcon = try? container.decode(String.self, forKey: .idIcon)
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
