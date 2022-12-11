//
//  CurrencyCellViewModel.swift
//  CurrencyConverterApp
//
//  Created by Passant Abdelatif on 11/12/2022.
//

import Foundation
import Combine

final class CurrencyCellViewModel {
    @Published var symbol: String = ""
    @Published var rate: String = ""
        
    private let currencyRate: CurrencyRateModel
    
    init(currencyRate: CurrencyRateModel) {
        self.currencyRate = currencyRate
        
        setUpBindings()
    }
    
    private func setUpBindings() {
        symbol = currencyRate.symbol ?? ""
        rate = "\(currencyRate.rate ?? 0)"
    }
}
