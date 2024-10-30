//
//  CurrencyList.swift
//  CurrencyConverter
//
//  Created by Nana on 30/10/24.
//

import Foundation

// MARK: - CurrencyList
struct CurrencyList: Codable {
    let currencies: [String: String]
    let status: String
}
