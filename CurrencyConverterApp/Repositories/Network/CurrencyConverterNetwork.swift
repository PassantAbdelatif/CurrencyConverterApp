//
//  CurrencyConverterNetwork.swift
//  CurrencyConverterApp
//
//  Created by Passant Abdelatif on 11/12/2022.
//

import Foundation
import Moya
import UIKit
import Combine
protocol CurrencyConverterNetworkProtocol {
    func fetchCurrencyConverterValue(from: String,
                                     to: String,
                                     amount: Double) -> AnyPublisher<Double, Error>
}
final class CurrencyConverterNetwrok: CurrencyConverterNetworkProtocol {
    
    private let provider = MoyaProvider<CurrencyServices>()
    
    func fetchCurrencyConverterValue(from: String,
                                     to: String,
                                     amount: Double) -> AnyPublisher<Double, Error> {
        
        provider.requestPublisher(.convertAmountByRate(from: from,
                                                       to: to,
                                                       amount: amount),
                                  callbackQueue: .main)
        .map(CurrencyConverterModel.self)
        .map({ response in
            if let result = response.result {
                return result
            }
            return 0
        })
        .mapError({$0 as Error})
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
