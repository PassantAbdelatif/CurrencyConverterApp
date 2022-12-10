//
//  NewEmptyFavoriteView.swift
//  BeutiCustomer
//
//  Created by Passant Abdelatif on 05/11/2022.
//


import UIKit

class EmptyView: UIView {
    
    @IBOutlet var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("EmptyView", owner: self, options: nil)
        self.addSubview(view)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        self.view.frame = self.bounds
    }

}
