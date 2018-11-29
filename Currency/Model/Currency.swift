//
//  CurrencyBase.swift
//  Currency
//
//  Created by Samson Lopez on 29/11/2018.
//  Copyright © 2018 Samson Lopez. All rights reserved.
//

import Foundation

// Domain model to decode currency rates in JSON data from currency data service.

struct Currency: Codable {
    var base: String
    var date: String
    var rates: [String: Double]
}
