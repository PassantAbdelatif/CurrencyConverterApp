//
//  ErrorResponce.swift
//  NewsApplication
//
//  Created by ModyMayaAser on 08/03/2022.
//

import Foundation

// MARK: - ErrorResponce
struct ErrorResponse: Codable {
    let error: ErrorData?
}

// MARK: - ErrorData
struct ErrorData: Codable {
    let code: String?
    let type: String?
    let info: String?
}

