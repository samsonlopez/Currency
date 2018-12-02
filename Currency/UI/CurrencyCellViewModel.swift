//
//  CurrencyCellViewModel.swift
//  Currency
//
//  Created by Samson Lopez on 01/12/2018.
//  Copyright © 2018 Samson Lopez. All rights reserved.
//

import Foundation

class CurrencyCellViewModel {

    var currencyCode:String?
    var currencyName:String?
    
    func getRate(currencyBaseValue: Double, currencyViewModel: CurrencyViewModel) -> Double? {
        var rateForBaseValue: Double?
        if let currency = currencyViewModel.currency, let currencyCode = currencyCode, let rate = currency.rates[currencyCode] {
            rateForBaseValue = currencyBaseValue*rate
        }

        return rateForBaseValue
    }

}
