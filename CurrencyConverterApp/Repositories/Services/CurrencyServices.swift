//
//  CurrencyService.swift
//  CurrencyConverterApp
//
//  Created by Passant Abdelatif on 10/12/2022.
//

import Foundation
import Moya

enum CurrencyServices {
    case getLatestCurrencyRates(baseCurrency: String)
    case convertAmountByRate(from: String,
                             to: String,
                             amount: Double)
}

extension CurrencyServices: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: APPURL.BaseURL) else { fatalError() }
            return url
      
    }
    
    var path: String {
        switch self {
        case .getLatestCurrencyRates:
            return APPURL.Paths.getLatestRates
        case .convertAmountByRate:
            return APPURL.Paths.convertAmountByRate
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getLatestCurrencyRates:
            return .get
        case .convertAmountByRate:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getLatestCurrencyRates(let baseCurrency):
            return .requestParameters(parameters: [Key.Headers.baseKey: baseCurrency],
                                      encoding: URLEncoding.queryString)
        case .convertAmountByRate(let from,
                                  let to,
                                  let amount):
            return .requestParameters(parameters: [Key.Headers.from: from,
                                                   Key.Headers.to: to,
                                                   Key.Headers.amount: amount],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [Key.Headers.apikey: Key.FixerApiKey.apikey]
    }
    
}
