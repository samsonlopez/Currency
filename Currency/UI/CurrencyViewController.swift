//
//  CurrencyViewController.swift
//  Currency
//
//  Created by Samson Lopez on 29/11/2018.
//  Copyright © 2018 Samson Lopez. All rights reserved.
//

import UIKit

class CurrencyViewController: UITableViewController, UITextFieldDelegate {

    // ViewModel property for CurrencyViewController (MVVM Architecture)
    lazy var viewModel: CurrencyViewModel = {
        return CurrencyViewModel()
    }()
    
    // Current base currency and value for which rates are displayed.
    var baseCurrencyCode:String = Global.defaultBaseCurrency
    var baseCurrencyValue: Double = 1.0
    
    // Currency codes maintained in the order to display in list.
    var currencyCodes = Global.currencyCodes
    
    // Timer to fetch currency rates repeateadly.
    var fetchTimer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial retrieval of currency rates.
        fetchCurrency()
        
        // Create and run the timer to fetch rates every 1 second.
        fetchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.fetchCurrency()
        })
    }
    
    // Fetch data from data service and refersh the currency.
    func fetchCurrency() {
        viewModel.fetchData(baseCurrency: baseCurrencyCode) { [weak self] (success, error) in
            DispatchQueue.main.sync {
                self?.refreshCurrency()
            }
        }
    }
    
    // Refresh the currency rates in the list with the current baseCurrency.
    func refreshCurrency() {
        print("Refreshing currency")
        
        let tableView = self.view as! UITableView
        
        for row in 1...currencyCodes.count-1 {
            if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? CurrencyCellView {
                
                let rateForBaseValue = cell.viewModel.getRate(currencyBaseValue: baseCurrencyValue, currencyViewModel:viewModel)
                cell.rateTextField.text = rateForBaseValue?.description
            }
        }
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyCodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyCellView
     
        let currencyCode = currencyCodes[indexPath.row]
        cell.viewModel.currencyCode = currencyCode
        cell.viewModel.currencyName = Global.currencies[currencyCodes[indexPath.row]]

        cell.textLabel?.text = String(describing: currencyCode)
        cell.detailTextLabel?.text = Global.currencies[currencyCodes[indexPath.row]]

        cell.rateTextField.delegate = self
        if indexPath.row == 0 {
            cell.rateTextField.text = baseCurrencyValue.description
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: 0)) as! CurrencyCellView

        cell.accessoryView = cell.rateTextField
        cell.isSelected = false
        
        // Change the base currency
        if let currencyCode = cell.viewModel.currencyCode {
            baseCurrencyCode = currencyCode
        }
        
        // Move the selected cell to top of the list
        let topIndexPath = IndexPath(row: 0, section: 0)
        tableView.moveRow(at: indexPath, to: topIndexPath)
        
        // Move the selected currency to top of the list
        let codeElement = currencyCodes.remove(at: indexPath.row)
        currencyCodes.insert(codeElement, at: 0)

        // Reset cell with base currency value
        cell.rateTextField.text = baseCurrencyValue.description

        // Enable editing for base currency
        cell.rateTextField.isEnabled = true
        cell.rateTextField.becomeFirstResponder()
                
        refreshCurrency()
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            if let baseValue = Double(updatedText) {
                baseCurrencyValue = baseValue
                refreshCurrency()
            }
        }
        print(string)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
