//
//  CommonTests.swift
//  CurrencyTests
//
//  Created by Samson Lopez on 02/12/2018.
//  Copyright © 2018 Samson Lopez. All rights reserved.
//

import XCTest
import Foundation

@testable import Currency

class CommonTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testFormatRate_ReturnsCorrectRate() {
        let rate = 123456.789
        let locale = Locale(identifier:"en_GB")

        let formattedRate = Common.formatRate(rate: rate, locale: locale)
        
        let expectedFormattedRate = "123,456.79"
        XCTAssertEqual(formattedRate, expectedFormattedRate, "Formatted rate incorrect")
    }

}
