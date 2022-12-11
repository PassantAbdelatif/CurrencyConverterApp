//
//  CurrencyRatesNetwork.swift
//  CurrencyConverterApp
//
//  Created by Passant Abdelatif on 10/12/2022.
//

import Foundation
import Moya
import UIKit
import Combine

enum ServiceError: Error {
    case url(URLError)
    case urlRequest
    case decode
}

protocol CurrencyRatesNetwrokProtocol {
    func fetchCurrencyRates(baseCurrency: String) -> AnyPublisher<[CurrencyRateModel], Error>
}
final class CurrencyRatesNetwrok: CurrencyRatesNetwrokProtocol {
    
    private let provider = MoyaProvider<CurrencyServices>()
    
    func fetchCurrencyRates(baseCurrency: String) -> AnyPublisher<[CurrencyRateModel], Error> {
        
        provider.requestPublisher(.getLatestCurrencyRates(baseCurrency: baseCurrency),
                                  callbackQueue: .main)
        .map(CurrencyRatesResponse.self)
        .map({ response in
            if let rates = response.rates,
               !rates.isEmpty {
                var ratesObjectsArray = [CurrencyRateModel]()
                for (symbol, rate) in rates {
                    ratesObjectsArray.append(CurrencyRateModel(symbol: symbol, rate: rate))
                }
                return ratesObjectsArray.sorted(by: { $0.symbol ?? "" < $1.symbol ?? "" })
            } else {
               
            }
            return []
        })
        .mapError({$0 as Error})
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
