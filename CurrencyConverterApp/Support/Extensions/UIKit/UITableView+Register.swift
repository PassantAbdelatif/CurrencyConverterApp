//
//  UITableView+Register.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 05/11/2022.
//


import UIKit

extension UITableView {
    
    func registerNibFor(cellClass: UITableViewCell.Type) {
        self.register(UINib(nibName: cellClass.cellNibName, bundle: nil),
                      forCellReuseIdentifier: cellClass.cellIdentifier)
    }
    
    func registerNibFor(headerFooterViewClass: UITableViewHeaderFooterView.Type) {
        self.register(UINib(nibName: headerFooterViewClass.viewNibName, bundle: nil),
                      forHeaderFooterViewReuseIdentifier: headerFooterViewClass.viewIdentifier)
    }
    
    func registerClassFor(cellClass: UITableViewCell.Type) {
        self.register(cellClass, forCellReuseIdentifier: cellClass.cellIdentifier)
    }
    
    func registerClassFor(headerFooterViewClass: UITableViewHeaderFooterView.Type) {
        self.register(headerFooterViewClass,
                      forHeaderFooterViewReuseIdentifier: headerFooterViewClass.viewIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type) -> T {
        guard let cell: T = self.dequeueReusableCell(withIdentifier: cellClass.cellIdentifier) as? T else {
            fatalError("no \(cellClass.cellIdentifier) registered")
        }
        return cell
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type, indexPath: IndexPath) -> T {
        guard let cell: T = self.dequeueReusableCell(withIdentifier: cellClass.cellIdentifier,
                                                     for: indexPath) as? T else {
                                                        fatalError("no \(cellClass.cellIdentifier) registered")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(headerFooterViewClass: T.Type) -> T? {
        return self.dequeueReusableHeaderFooterView(withIdentifier: headerFooterViewClass.viewIdentifier) as? T
    }
}

extension UITableViewCell {
    
    static var cellIdentifier: String {
        return NSStringFromClass(Self.self)
    }
    
    static var cellNibName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
}

extension UITableViewHeaderFooterView {
    
    static var viewIdentifier: String {
        return NSStringFromClass(Self.self)
    }
    
    static var viewNibName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
}
