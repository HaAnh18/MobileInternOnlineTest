//
//  ConverterCurrency.swift
//  ConverterCurrency
//
//  Created by Nana on 29/10/24.
//

import Foundation

// MARK: - ConverterCurrency
/// A model representing the currency conversion data, including base currency, conversion rates, and status.
struct ConverterCurrency: Codable {
    let baseCurrencyCode, baseCurrencyName, amount, updatedDate: String
    let rates: [String: Rate]  // Dictionary of rates with currency codes as keys
    let status: String  // Status of the conversion data retrieval

    // Coding keys to map JSON keys to Swift properties for Codable conformance
    enum CodingKeys: String, CodingKey {
        case baseCurrencyCode = "base_currency_code"
        case baseCurrencyName = "base_currency_name"
        case amount
        case updatedDate = "updated_date"
        case rates, status
    }
}

// MARK: - Rate
/// A model representing the rate details for a particular currency, including currency name, rate, and rate for a given amount.
struct Rate: Codable {
    let currencyName, rate, rateForAmount: String  // Name of the currency, exchange rate, and calculated rate for a specified amount

    // Coding keys to map JSON keys to Swift properties for Codable conformance
    enum CodingKeys: String, CodingKey {
        case currencyName = "currency_name"
        case rate
        case rateForAmount = "rate_for_amount"
    }
}
