//
//  ConverterCurrency.swift
//  ConverterCurrency
//
//  Created by Nana on 29/10/24.
//

import Foundation

// MARK: - ConverterCurrency
struct ConverterCurrency: Codable {
    let baseCurrencyCode, baseCurrencyName, amount, updatedDate: String
     let rates: [String: Rate]
     let status: String

     enum CodingKeys: String, CodingKey {
         case baseCurrencyCode = "base_currency_code"
         case baseCurrencyName = "base_currency_name"
         case amount
         case updatedDate = "updated_date"
         case rates, status
     }
 }

 // MARK: - Rate
 struct Rate: Codable {
     let currencyName, rate, rateForAmount: String

     enum CodingKeys: String, CodingKey {
         case currencyName = "currency_name"
         case rate
         case rateForAmount = "rate_for_amount"
     }
 }
