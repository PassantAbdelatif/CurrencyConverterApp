//
//  CurrencyService.swift
//  CurrencyConverterApp
//
//  Created by Passant Abdelatif on 10/12/2022.
//

import Foundation
import Moya

enum CurrencyServices {
    case getLatestCurrencyRates(baseCurrency : String)
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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getLatestCurrencyRates:
            return .get
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return [Key.Headers.apikey: Key.FixerApiKey.apikey]
    }
    
}
