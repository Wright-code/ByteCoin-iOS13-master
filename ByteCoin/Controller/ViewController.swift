//
//  ViewController.swift
//  ByteCoin
//
//  Created by Harry Wright on 22/07/2020.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitCoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        
        coinManager.fetchCoinageValue(currency: 0)
        
    }

//MARK: UI Picker Delegate
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.fetchCoinageValue(currency: row)
        currencyLabel.text = coinManager.currencyArray[row]
    }

}
//MARK: Coin Manager
extension ViewController: CoinManagerDelegate {
    func didUpdateExchangeValue(exchange: Coinage) {
        DispatchQueue.main.async {
            self.bitCoinLabel.text = "= \(exchange.valueFormatted)"
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
}

