//
//  CurrencyList.swift
//  CurrencyConverter
//
//  Created by Nana on 30/10/24.
//

import Foundation

// MARK: - CurrencyList
/// A model representing a list of currencies with their codes and names, along with a status indicator.
struct CurrencyList: Codable {
    let currencies: [String: String]  // Dictionary of currency codes and their corresponding names
    let status: String  // Status indicating the result of the currency list retrieval (e.g., success or failure)

    // No custom coding keys are needed here since JSON keys match property names
}
