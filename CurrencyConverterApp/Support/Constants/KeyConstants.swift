//
//  AppConstants.swift
//  GitHubRepositoriesApp
//
//  Created by Passant Abdelatif on 07/11/2022.
//

import Foundation
struct Key {

        static let DeviceType = "iOS"
       
        struct UserDefaults {
            static let k_App_Running_FirstTime = "userRunningAppFirstTime"
        }

        struct Headers {
            static let Authorization = "Authorization"
            static let ContentType = "Content-Type"
            static let apikey = "apikey"
            static let baseKey = "base"
            static let from = "from"
            static let to = "to"
            static let amount = "amount"
        }
    
        struct FixerApiKey {
            static let apikey = "KtbN4IvLSqikqXLfluP0wLOwSXCH7xVb"
        }

        struct ErrorMessage{
            static let listNotFound = "ERROR_LIST_NOT_FOUND"
            static let validationError = "ERROR_VALIDATION"
        }
    }
