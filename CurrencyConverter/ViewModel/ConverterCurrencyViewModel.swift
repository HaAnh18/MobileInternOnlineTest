//
//  ConverterCurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by Nana on 29/10/24.
//

import Foundation

class ConverterCurrencyViewModel: ObservableObject {
    @Published var converterInfo: ConverterCurrency?
    @Published var currencyList: [String] = []
    
    //Fetches the list of available currencies from the API
    // - Parameter completion: A closure that returns the list of currency codes as an optional array
    func fetchCurrencyList(completion: @escaping ([String]?) -> Void) {
        // Constructing the URL for the API request
        guard let url = URL(string: "https:api.getgeoapi.com/v2/currency/list?api_key=c3e03ab38814394db7845e630ced2273309ebb14&format=json") else {
            completion(nil) // If URL creation fails, call completion with nil
            return
        }
        
        // Creating the data task to fetch data from the API
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil) // If data is nil or there is an error, call completion with nil
                return
            }
            
            do {
                // Decoding the data into a CurrencyList model
                let decodedData = try JSONDecoder().decode(CurrencyList.self, from: data)
                DispatchQueue.main.async {
                    // Updating currencyList on the main thread
                    self.currencyList = Array(decodedData.currencies.keys)
                    completion(Array(decodedData.currencies.keys)) // Calling completion with the currency codes array
                }
            } catch {
                // Printing any decoding errors for debugging
                print(error)
                completion(nil)
            }
        }
        
        // Starting the data task
        task.resume()
        
    }
    
    // Fetches currency conversion data from the API
    func fetchCurrencyConverter(from: String, to: String, amount: String, completion: @escaping (ConverterCurrency?) -> Void) {
        // Percent-encoding the input parameters to make them safe for URL use
        guard let from = from.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let to = to.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let amount = amount.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: "https://api.getgeoapi.com/v2/currency/convert?api_key=c3e03ab38814394db7845e630ced2273309ebb14&from=\(from)&to=\(to)&amount=\(amount)&format=json") else {
            completion(nil) // If URL creation fails, call completion with nil and exit
            return
        }
        
        // Create a data task to fetch data from the URL
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            // Check if data was received successfully and if there is no error
            guard let data = data, error == nil else {
                return
            }
            
            do {
                // Decode the data into a ConverterCurrency object
                let decodedData = try JSONDecoder().decode(ConverterCurrency.self, from: data)
                DispatchQueue.main.async {
                    self.converterInfo = decodedData // Update the published property on the main thread
                    completion(decodedData)
                }
            } catch {
                // Print any decoding errors for debugging
                print(error)
            }
        }
        
        // Start the data task
        task.resume()
    }
}
