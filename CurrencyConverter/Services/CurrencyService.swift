//
//  CurrencyService.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 20/06/22.
//

import UIKit

class CurrencyService: NSObject {
    let url: String = "https://cbu.uz/uz/arkhiv-kursov-valyut/json/"

    static let shared: CurrencyService = {
        let objc = CurrencyService()
        objc.getData()
        return objc
    }()

    var data: [Currencyy] = []
    var currencyTypes: [String] = []

    func getData() {
        guard let url = URL(string: url) else {
            return
        }
        URLSession.shared
            .dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    do {
                        guard let data = data else {
                            return
                        }

                        self.data = try JSONDecoder().decode([Currencyy].self, from: data)
                        self.currencyTypes = self.data.compactMap { $0.ccy }


                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .resume()
    }

    func fetchData(completion: (([Currencyy]?) -> Void)?) {
        guard let url = URL(string: url) else {
            completion?(nil)
            return
        }
        URLSession.shared
            .dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    do {
                        guard let data = data else {
                            completion?(nil)
                            return
                        }

                        self.data = try JSONDecoder().decode([Currencyy].self, from: data)

                        completion?(self.data)
                    } catch {
                        print(error.localizedDescription)
                        completion?(nil)
                    }
                }
            }
            .resume()
    }
}



struct Currencyy: Decodable {
    let rate: String?
    let id: Int?
    let code: Int?
    let ccy: String?
    let ccyNmRU: String?
    let ccyNm_UZ: String?
    let ccyNm_UZC: String?
    let ccyNm_EN: String?
    let nominal: String?
    let diff: String?
    let date: String?

    enum CodingKeys: String, CodingKey {
        typealias RawValue = String

        case rate = "Rate"
        case id = "id"
        case code = "Code"
        case ccy = "Ccy"
        case ccyNm_RU = "CcyNm_RU"
        case ccyNm_UZ = "CcyNm_UZ"
        case ccyNm_UZC = "CcyNm_UZC"
        case ccyNm_EN = "CcyNm_EN"
        case nominal = "Nominal"
        case diff = "Diff"
        case date = "Date"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.diff = try? container.decode(String.self, forKey: .diff)
        self.nominal = try? container.decode(String.self, forKey: .nominal)
        self.ccy = try? container.decode(String.self, forKey: .ccy)
        self.code = try? container.decode(Int.self, forKey: .code)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.rate = try? container.decode(String.self, forKey: .rate)
        self.date = try? container.decode(String.self, forKey: .date)
        self.ccyNm_EN = try? container.decode(String.self, forKey: .ccyNm_EN)
        self.ccyNm_UZ = try? container.decode(String.self, forKey: .ccyNm_UZ)
        self.ccyNm_UZC = try? container.decode(String.self, forKey: .ccyNm_UZC)
        self.ccyNmRU = try? container.decode(String.self, forKey: .ccyNm_RU)
    }

}
