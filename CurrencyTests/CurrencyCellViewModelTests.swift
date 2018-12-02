//
//  CurrencyCellViewModelTests.swift
//  CurrencyTests
//
//  Created by Samson Lopez on 01/12/2018.
//  Copyright © 2018 Samson Lopez. All rights reserved.
//

import XCTest
@testable import Currency

class CurrencyCellViewModelTests: XCTestCase {

    var viewModelUnderTest: CurrencyCellViewModel!
    
    override func setUp() {
        viewModelUnderTest = CurrencyCellViewModel()
    }
    
    override func tearDown() {
        viewModelUnderTest = nil
    }
    
    func testGetRateForBaseValue_ReturnsCorrectRate() {
        
        let currency = TestData.getTestCurrency()

        let baseCurrencyValue: Double = 2.5
        
        viewModelUnderTest.currencyCode = "GBP"

        let currencyViewModel = CurrencyViewModel()
        currencyViewModel.currency = currency
        
        let rateForBaseValue = viewModelUnderTest.getRate(currencyBaseValue: baseCurrencyValue, currencyViewModel: currencyViewModel)

        let rateForCurrency = 0.89614
        let expectedRateForBaseValue = baseCurrencyValue * rateForCurrency
        
        XCTAssertEqual(rateForBaseValue, expectedRateForBaseValue, "Incorrect rate")
    }

}
