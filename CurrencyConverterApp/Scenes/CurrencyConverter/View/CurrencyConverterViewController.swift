//
//  CurrencyConverterViewController.swift
//  CurrencyConverterApp
//
//  Created by Passant Abdelatif on 11/12/2022.
//

import UIKit
import Combine

class CurrencyConverterViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var toCurrencySymbolLabel: UILabel!
    @IBOutlet weak var toCurrencyRateLabel: UILabel!
    @IBOutlet weak var baseCurrencyLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - variables
    var viewModel: CurrencyConverterViewModel!
    private var bindings = Set<AnyCancellable>()
    
    // MARK: - life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
    }
    
}

// MARK: - binding Data
extension CurrencyConverterViewController {

    private func setUpBindings() {
        func bindViewToViewModel() {
          
            amountTextField.textPublisher
                .debounce(for: 0.5, scheduler: RunLoop.main)
                .removeDuplicates()
                .sink { [weak viewModel] in
                    if !$0.isEmpty {
                        viewModel?.convert(amount: $0)
                    }
                }
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            viewModel.$currencyResult
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] result in
                    self?.toCurrencyRateLabel.text = "\(result)"
                })
                .store(in: &bindings)
            
            viewModel.$fromCurrency
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] from in
                    self?.baseCurrencyLabel.text = "\(from)"
                })
                .store(in: &bindings)
            
            viewModel.$toCurrencyRate
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] to in
                    self?.toCurrencyRateLabel.text = "\(to ?? 0)"
                })
                .store(in: &bindings)
            
            viewModel.$toCurrencySymbol
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] toSybmol in
                    self?.toCurrencySymbolLabel.text = toSybmol
                })
                .store(in: &bindings)
            
            let stateValueHandler: (CurrencyRatesViewModelState) -> Void = { [weak self] state in
                switch state {
                case .startedLoading:
                    self?.startLoading()
                case .finishedLoading:
                    self?.stopLoading()
                case .error(let error):
                    self?.showError(message: error)
                }
            }
            
            viewModel.$state
                .receive(on: RunLoop.main)
                .sink(receiveValue: stateValueHandler)
                .store(in: &bindings)
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
}

// MARK: - currency rates controller states
extension CurrencyConverterViewController {
    func showError(message: String?) {
        displayMessage(title: "Something went wrong!", message: message)
    }

    func startLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
    }

}
