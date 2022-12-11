//
//  CurrencyConverterViewModel.swift
//  CurrencyConverterApp
//
//  Created by Passant Abdelatif on 11/12/2022.
//

import UIKit
import Combine

class CurrencyConverterViewModel {
    @Published var fromCurrency: String = ""
    @Published var toCurrencySymbol: String?
    @Published var toCurrencyRate: Double?
    @Published private(set) var state: CurrencyRatesViewModelState = .startedLoading
    @Published private(set) var currencyResult: Double = 0

    private var amount: String = ""
    private let selectedCurrencyRate: CurrencyRateModel
    
    private let currencyConverterService: CurrencyConverterNetworkProtocol
    private var bindings = Set<AnyCancellable>()
    

    init(currentBaseCurrency: String,
         selectedCurrencyRate: CurrencyRateModel,
         currencyConverterService: CurrencyConverterNetworkProtocol = CurrencyConverterNetwrok()) {
        self.selectedCurrencyRate = selectedCurrencyRate
        self.fromCurrency = currentBaseCurrency
        self.currencyConverterService = currencyConverterService
        setUpBindings()
    }
    
    private func setUpBindings() {
        toCurrencyRate = selectedCurrencyRate.rate
        toCurrencySymbol = selectedCurrencyRate.symbol
    }
    
    func convert(amount: String) {
        self.amount = amount
        convertAmount(with: amount)
    }

}

extension CurrencyConverterViewModel {
    private func convertAmount(with amount: String) {
        state = .startedLoading
        
        let receiveCompletionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.state = .finishedLoading
                self?.state = .error(error.localizedDescription)
            case .finished:
                self?.state = .finishedLoading
            }
        }
        
        let valueHandler: (Double) -> Void = { [weak self] result in
            self?.currencyResult = result
        }
        
        currencyConverterService
            .fetchCurrencyConverterValue(from: fromCurrency,
                                         to: toCurrencySymbol ?? "",
                                         amount: Double(amount) ?? 0)
            .sink(receiveCompletion: receiveCompletionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
}
