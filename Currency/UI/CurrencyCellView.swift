//
//  CurrencyViewCell.swift
//  Currency
//
//  Created by Samson Lopez on 30/11/2018.
//  Copyright © 2018 Samson Lopez. All rights reserved.
//

import UIKit

class CurrencyCellView: UITableViewCell {

    // ViewModel property for CurrencyCellView (MVVM Architecture)
    lazy var viewModel: CurrencyCellViewModel = {
        return CurrencyCellViewModel()
    }()

    // UI Controls
    var rateTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Create rate text input field.
        let rateTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
        rateTextField.textAlignment = .right
        rateTextField.isEnabled = false
        self.accessoryView = rateTextField
        self.rateTextField = rateTextField
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
