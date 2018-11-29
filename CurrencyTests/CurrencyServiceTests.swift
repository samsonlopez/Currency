//
//  CurrencyServiceTests.swift
//  CurrencyTests
//
//  Created by Samson Lopez on 29/11/2018.
//  Copyright © 2018 Samson Lopez. All rights reserved.
//

import XCTest
@testable import Currency

class CurrencyServiceTests: XCTestCase {

    var currencyServiceUnderTest: CurrencyService!
    
    override func setUp() {
        currencyServiceUnderTest = CurrencyService()
    }
    
    override func tearDown() {
        currencyServiceUnderTest = nil
    }

    func testGetCurrency_ReturnsCorrectValues() {
        let expectation = XCTestExpectation(description: "Call returns result")
        
        let testData = TestData.getTestData()
        
        // Create a mock session object which DOES NOT return an Error.
        let urlSession = MockURLSession(data: testData, response:nil, error: nil)
        XCTAssertNotNil(urlSession, "URLSession is nil")
        
        var isSuccessfull = false;
        var currency: Currency?
        let baseCurrency = "EUR"
        
        currencyServiceUnderTest.getCurrency(baseCurrency: baseCurrency, session: urlSession) { (success, currencyRet, error) in
            if success {
                isSuccessfull = true
                currency = currencyRet
            }
            expectation.fulfill() // Expectation is fullfilled even if submission fails.
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertTrue(isSuccessfull, "Call not successfull")
        
        var isValuesCorrect = false

        // Here we are testing if the currency returned from the data service is the correct base and returns all 32 rates.
        // These can be split into separate tests, with more tests added.
        if let base = currency?.base, let rates = currency?.rates {
            if (base == "EUR" && rates.count == 32) {
                isValuesCorrect = true
            }
        }

        XCTAssertTrue(isValuesCorrect, "Incorrect currency values")
    }
    
    // TODO: Separate tests for different cases of base and rates on data service.
    
    
    enum DataRequestFailedError: Error {
        case dataRequestFailed
    }
    
    func testGetCurrency_Fails() {
        let expectation = XCTestExpectation(description: "Call returns result")
        
        // Create a mock session object which DOES return an Error.
        let urlSession = MockURLSession(data: nil, response:nil, error: DataRequestFailedError.dataRequestFailed)
        XCTAssertNotNil(urlSession, "URLSession is nil")
        
        var isSuccessfull = false;
        let baseCurrency = "EUR"

        currencyServiceUnderTest.getCurrency(baseCurrency: baseCurrency, session: urlSession) { (success, currency, error) in
            if success {
                isSuccessfull = true
            }
            expectation.fulfill() // Expectation is fullfilled even if submission fails.
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertFalse(isSuccessfull, "Call did not fail")
    }
}
