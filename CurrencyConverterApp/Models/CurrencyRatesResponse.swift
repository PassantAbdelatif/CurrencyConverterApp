//
//  CurrencyRatesResponse.swift
//  CurrencyConverterApp
//
//  Created by Passant Abdelatif on 10/12/2022.
//

import Foundation

// MARK: - rates main response
struct CurrencyRatesResponse: Codable {
    let base: String?
    let date: String?
    let rates: [String: Double]?
}

struct CurrencyRateModel {
    let symbol: String?
    let rate: Double?
}
