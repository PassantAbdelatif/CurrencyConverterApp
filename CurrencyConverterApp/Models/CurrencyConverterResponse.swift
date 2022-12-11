//
//  CurrencyConverterResponse.swift
//  CurrencyConverterApp
//
//  Created by Passant Abdelatif on 11/12/2022.
//

import Foundation
struct CurrencyConverterModel: Codable {

  enum CodingKeys: String, CodingKey {
    case result
    case date
    case success
    case info
  }
  var result: Double?
  var date: String?
  var success: Bool?
  var info: Info?
}

struct Info: Codable {

  enum CodingKeys: String, CodingKey {
    case timestamp
    case rate
  }

  var timestamp: Int?
  var rate: Float?

}
