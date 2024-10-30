//
//  ConverterCurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by Nana on 29/10/24.
//

import Foundation

class ConverterCurrencyViewModel: ObservableObject {
    @Published var converterInfo: ConverterCurrency?
    @Published var message: String?
    @Published var currencyList: [String] = []
    
    func fetchCurrencyList(completion: @escaping ([String]?) -> Void) {
        guard let url = URL(string: "https:api.getgeoapi.com/v2/currency/list?api_key=c3e03ab38814394db7845e630ced2273309ebb14&format=json") else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(CurrencyList.self, from: data)
                DispatchQueue.main.async {
                    self.currencyList = Array(decodedData.currencies.keys)
                    completion(Array(decodedData.currencies.keys))

                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
        
    }
    
    func fetchCurrencyConverter(from: String, to: String, amount: String, completion: @escaping (ConverterCurrency?) -> Void) {
        guard let from = from.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let to = to.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let amount = amount.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: "https://api.getgeoapi.com/v2/currency/convert?api_key=c3e03ab38814394db7845e630ced2273309ebb14&from=\(from)&to=\(to)&amount=\(amount)&format=json") else {
            completion(nil)
            return
        }
                        
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(ConverterCurrency.self, from: data)
                DispatchQueue.main.async {
                    self.converterInfo = decodedData
                    completion(decodedData)
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
