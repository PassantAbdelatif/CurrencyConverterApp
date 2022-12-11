//
//  CurrencyRateTableViewCell.swift
//  CurrencyConverterApp
//
//  Created by Passant Abdelatif on 10/12/2022.
//

import UIKit

class CurrencyRateTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyRateLabel: UILabel!
    @IBOutlet weak var currencyImageView: UIImageView!
    @IBOutlet weak var currencySymbolLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var viewModel: CurrencyCellViewModel!{
        didSet{setupUI()}
    }

}
extension CurrencyRateTableViewCell {
    func setupUI(){
        currencyRateLabel.text = viewModel.rate
        currencySymbolLabel.text = viewModel.symbol
    }
}
