//
//  UITextField+Extension.swift
//  CurrencyConverterApp
//
//  Created by Passant Abdelatif on 11/12/2022.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField } // receiving notifications with objects which are instances of UITextFields
            .compactMap(\.text) // extracting text and removing optional values (even though the text cannot be nil)
            .eraseToAnyPublisher()
    }
}
