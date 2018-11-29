//
//  CurrencyService.swift
//  Currency
//
//  Created by Samson Lopez on 29/11/2018.
//  Copyright © 2018 Samson Lopez. All rights reserved.
//

import Foundation

enum DataServiceError: String, Error {
    case downloadFailed = "Download failed"
    case connectionFailed = "Connnection failed"
}

protocol CurrencyDataAccess {
    func getCurrency(currencyCode: String, session: URLSession, complete: @escaping (_ success: Bool, _ currency: Currency?, _ error: DataServiceError?) -> ())
    func getSession() -> URLSession
}

// Data service for retrieving currency rates.
class CurrencyService {
    
    // Constants
    let serviceURL = URL(string:"https://revolut.duckdns.org/latest")
    let maxConnectionsPerHost = 1
    
    // Get currency method using completion handler
    func getCurrency(baseCurrency:String, session:URLSession, complete: @escaping (_ success: Bool, _ currency: Currency?, _ error: DataServiceError?) -> ()) {
        
        let urlRequest = getURLRequest()
        
        let dataTask = session.dataTask (with: urlRequest) { (data, response, error) in
            if(error != nil) {
                complete(false, nil, DataServiceError.downloadFailed)
            } else {
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let currency = try decoder.decode(Currency.self, from: data)
                        
                        complete(true, currency, nil)
                        
                    } catch let error {
                        print(error)
                        complete(false, nil, DataServiceError.downloadFailed)
                    }
                    
                } else {
                    complete(false, nil, DataServiceError.downloadFailed)
                }
            }
        }
        
        dataTask.resume()
    }
    
    private func getURLRequest() -> URLRequest {
        let urlRequest = URLRequest(url: serviceURL!)
        
        return urlRequest
    }
    
    func getSession() -> URLSession {
        let urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.httpMaximumConnectionsPerHost = maxConnectionsPerHost
        urlSessionConfiguration.timeoutIntervalForRequest = 2
        
        return URLSession(configuration: urlSessionConfiguration)
    }
    
}
