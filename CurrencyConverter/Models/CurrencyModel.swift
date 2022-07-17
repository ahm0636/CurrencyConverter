//
//  CurrencyModel.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 18/06/22.
//

import Foundation
import UIKit

struct Currency: Decodable {
    let name: String = ""
    var code: String = ""
    var image: String {
        return code + ".png"
    }
    var value: Double = 0
    var id: Int = 0
    var rate: String = ""
    var nominal: Int = 1
    var diff: String = ""
    var date: String = ""


}
