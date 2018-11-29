//
//  TestData.swift
//  CurrencyTests
//
//  Created by Samson Lopez on 29/11/2018.
//  Copyright © 2018 Samson Lopez. All rights reserved.
//

import Foundation

// Provides currency data from a static JSON file for creating initial list of countries.
// Also used for testing data service and viewModels which use data service.

class TestData {
    static func getTestData() -> Data {
        let path = Bundle.main.path(forResource: "testdata", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        
        return data
    }
}
