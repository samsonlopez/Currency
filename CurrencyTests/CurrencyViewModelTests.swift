//
//  CurrencyViewModelTests.swift
//  CurrencyTests
//
//  Created by Samson Lopez on 29/11/2018.
//  Copyright © 2018 Samson Lopez. All rights reserved.
//

import XCTest
@testable import Currency

class CurrencyViewModelTests: XCTestCase {

    var viewModelUnderTest: CurrencyViewModel!
    
    override func setUp() {
        viewModelUnderTest = CurrencyViewModel()
    }

    override func tearDown() {
        viewModelUnderTest = nil
    }
    
    func testFetchData_ReturnsCorrectData() {
        
        let expectation = XCTestExpectation(description: "Call returns result")
        
        let currency = TestData.getTestCurrency()

        // Use a mock data service to fetch test data
        let mockCurrencyDataService = MockCurrencyDataService()
        mockCurrencyDataService.currency = currency
        viewModelUnderTest.currencyDataAccess = mockCurrencyDataService
        
        var isSuccessfull = false;
        let baseCurrencyCode:String = Global.defaultBaseCurrency
        
        viewModelUnderTest.fetchData(baseCurrency: baseCurrencyCode) { (success, error) in
            if success {
                isSuccessfull = true
            }
            expectation.fulfill() // Expectation is fullfilled even if fetch fails.
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertTrue(isSuccessfull, "Call not successfull")
        
        var isValuesCorrect = false
        
        // Here we are testing if the currency returned from fetch is the correct base and returns all 32 rates.
        // These can be split into separate tests, with more tests added.
        if let base = currency?.base, let rates = currency?.rates {
            if (base == "EUR" && rates.count == 32) {
                isValuesCorrect = true
            }
        }
        
        XCTAssertTrue(isValuesCorrect, "Incorrect currency values")
    }

    func testFetchData_Fails() {
        
        let expectation = XCTestExpectation(description: "Call returns result")
        
        // Use a mock data service to fetch test currency.
        let mockCurrencyDataService = MockCurrencyDataService()
        mockCurrencyDataService.currency = nil // Set to nil for testing failure condition.
        viewModelUnderTest.currencyDataAccess = mockCurrencyDataService

        var isSuccessfull = false;
        let baseCurrencyCode:String = Global.defaultBaseCurrency
        
        viewModelUnderTest.fetchData(baseCurrency: baseCurrencyCode) { (success, error) in
            if success {
                isSuccessfull = true
            }
            expectation.fulfill() // Expectation is fullfilled even if fetch fails.
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertFalse(isSuccessfull, "Call not failed")
        
        let currency = viewModelUnderTest.currency
        XCTAssertNil(currency, "Currency value not nil")
    }
    
}

class MockCurrencyDataService: CurrencyService {
    
    var currency: Currency?
    
    override func getCurrency(baseCurrency: String, session:URLSession, complete: @escaping (_ success: Bool, _ currency: Currency?, _ error: DataServiceError?) -> ()) {
        
        if let currency = currency {
            complete(true, currency, nil)
        } else {
            complete(false, nil, DataServiceError.downloadFailed)
        }
    }
    
}
