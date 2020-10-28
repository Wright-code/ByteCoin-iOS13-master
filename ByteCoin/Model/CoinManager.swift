//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Harry Wright on 22/07/2020.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation


protocol CoinManagerDelegate {
    
    func didUpdateExchangeValue(exchange: Coinage)
    func didFailWithError(_ error: Error)
}

struct CoinManager {

    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "6C2845A1-BA61-4FE1-AE10-5EBFE99E4FA0"

    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func fetchCoinageValue (currency: Int) {
        let urlString = "\(baseURL)/\(currencyArray[currency])?apikey=\(apiKey)"
        peformRequest(with: urlString)
        print(urlString)
    }
    
    func peformRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                }
                if let safeData = data {
                    if let coinValue = self.parseJSON(coinData: safeData) {
                        self.delegate?.didUpdateExchangeValue(exchange: coinValue)
                        print(coinValue)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(coinData: Data) -> Coinage? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinModel.self, from: coinData)
            let value = decodedData.rate
        
            let coinage = Coinage(value: value)
            return coinage
            
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
        
    }

}
