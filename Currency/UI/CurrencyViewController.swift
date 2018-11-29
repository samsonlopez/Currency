//
//  CurrencyViewController.swift
//  Currency
//
//  Created by Samson Lopez on 29/11/2018.
//  Copyright © 2018 Samson Lopez. All rights reserved.
//

import UIKit

class CurrencyViewController: UITableViewController {

    // ViewModel property for CurrencyViewController (MVVM Architecture)
    lazy var viewModel: CurrencyViewModel = {
        return CurrencyViewModel()
    }()
    
    // Current base currency for which rates are displayed.
    var baseCurrency:String = Global.defaultBaseCurrency
    
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
        viewModel.fetchData(baseCurrency: baseCurrency) { [weak self] (success, error) in
            if success {
                self?.refreshCurrency(currency: self?.viewModel.currency)
            } else {
                self?.refreshCurrency(currency: nil)
            }
        }
    }
    
    // Refresh the currency rates in the list with the current baseCurrency.
    func refreshCurrency(currency: Currency?) {
        DispatchQueue.main.sync {
            print("Refreshing currency")
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
