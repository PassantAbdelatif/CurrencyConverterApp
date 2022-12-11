//
//  UITableViewCell+Configuration.swift
//  CurrencyConverterApp
//
//  Created by Passant Abdelatif on 10/12/2022.
//

import Foundation

protocol ConfigureCell {
    associatedtype DataType
    func configure(model: DataType)
}

protocol DelegateCell {
    associatedtype DataType
    func btnTap(model: DataType)
}
