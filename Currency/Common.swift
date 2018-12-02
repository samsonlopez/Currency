//
//  Common.swift
//  Currency
//
//  Created by Samson Lopez on 02/12/2018.
//  Copyright © 2018 Samson Lopez. All rights reserved.
//

import Foundation

class Common {
    
    static func formatRate(rate: Double, locale: Locale) -> String? {
        
        var formattedRate: String?
        
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        formattedRate = formatter.string(from: NSNumber(value: rate))
        
        return formattedRate
    }
    
}
