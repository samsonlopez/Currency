//
//  CurrencyUITests.swift
//  CurrencyUITests
//
//  Created by Samson Lopez on 29/11/2018.
//  Copyright © 2018 Samson Lopez. All rights reserved.
//

import XCTest

class CurrencyUITests: XCTestCase {

    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }

    override func tearDown() {
    }

    func testGBPBaseValueInputChange_EuroValueIsUpdated() {
        
        let app = XCUIApplication()
        
        let tablesQuery = app.tables

        let euroTextField = tablesQuery.cells["EUR, Euro"].children(matching: .textField).element
        let euroTextFieldValue = euroTextField.value as! String

        tablesQuery.cells["GBP, British Pound"].tap()
        let textField = tablesQuery.cells["GBP, British Pound"].children(matching: .textField).element
        
        let textFieldValue = textField.value as! String
        
        let characterCount: Int = textFieldValue.count
        for _ in 0..<characterCount {
            textField.typeText(XCUIKeyboardKey.delete.rawValue)
        }

        textField.typeText("2.0")

        let euroTextFieldNewValue = euroTextField.value as! String
        print("\(euroTextFieldValue) New: \(euroTextFieldNewValue)")

        XCTAssertNotEqual(euroTextFieldValue, euroTextFieldNewValue, "Rates not updated on base value input")
    }

}
