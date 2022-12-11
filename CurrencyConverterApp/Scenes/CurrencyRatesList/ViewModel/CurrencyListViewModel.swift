//
//  CurrencyListViewModel.swift
//  CurrencyConverterApp
//
//  Created by Passant Abdelatif on 11/12/2022.
//

import Foundation
import Combine
import Moya

enum CurrencyRatesViewModelState: Equatable {
    case startedLoading
    case finishedLoading
    case error(String)
}

class CurrencyListViewModel {
    @Published private(set) var currencyRates: [CurrencyRateModel] = []
    @Published private(set) var state: CurrencyRatesViewModelState = .startedLoading
    private var currentCurrencyBase: String = ""
    
    private let currencyRatesService: CurrencyRatesNetwrokProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(currencyRatesService: CurrencyRatesNetwrokProtocol = CurrencyRatesNetwrok()) {
        self.currencyRatesService = currencyRatesService
    }
    func getLatestRates(base: String) {
        currentCurrencyBase = base
        fetchCurrencyRates(with: base)
    }

    func retrySearch() {
        fetchCurrencyRates(with: currentCurrencyBase)
    }
}


extension CurrencyListViewModel {
    func fetchCurrencyRates(with base: String) {
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
        
        let valueHandler: ([CurrencyRateModel]) -> Void = { [weak self] rates in
            self?.currencyRates = rates
        }
        
        currencyRatesService
            .fetchCurrencyRates(baseCurrency: base)
            .sink(receiveCompletion: receiveCompletionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
}
