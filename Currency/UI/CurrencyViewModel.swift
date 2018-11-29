//
//  CurrencyViewModel.swift
//  Currency
//
//  Created by Samson Lopez on 29/11/2018.
//  Copyright © 2018 Samson Lopez. All rights reserved.
//

import Foundation

class CurrencyViewModel {
    
    // Data access service delegate
    lazy var currencyDataAccess: CurrencyDataAccess = {
        return CurrencyService()
    }()
    
    // Current currency
    var currency: Currency?
    
    // Fetch the currency rates from the data service
    func fetchData(baseCurrency:String, complete: @escaping (_ success: Bool, _ error: DataServiceError?) -> ()) {
        let session = currencyDataAccess.getSession()
        
        _ = currencyDataAccess.getCurrency(baseCurrency:baseCurrency, session: session, complete: { (success, currency, error) in
            if success {
                self.currency = currency
                complete(success, nil)
            } else {
                self.currency = nil
                complete(success, DataServiceError.downloadFailed)
            }
        })
    }
    
}
