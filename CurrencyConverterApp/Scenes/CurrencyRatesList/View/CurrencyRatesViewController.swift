//
//  CurrencyRatesViewController.swift
//  CurrencyConverterApp
//
//  Created by Passant Abdelatif on 10/12/2022.
//

import UIKit
import Combine
class CurrencyRatesViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var currencyBaseTextLabel: UILabel!
    @IBOutlet weak var currencyRatesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Outlets
    var currencyRatesArray = [CurrencyRateModel]()
    private lazy var viewModel = CurrencyListViewModel()
    private var bindings = Set<AnyCancellable>()
    
    @Published var newBaseCurrency: String = ""
    
    // MARK: - lifeCycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        registerCells()
        setUpBindings()
    }
}
// MARK: - UI & Register Cells
extension CurrencyRatesViewController {
    func setUpUI() {
        
    }
    func registerCells() {
        //CurrencyRateTableViewCell
        currencyRatesTableView.delegate = self
        currencyRatesTableView.dataSource = self
        currencyRatesTableView.registerNibFor(cellClass: CurrencyRateTableViewCell.self)
    }
}
// MARK: - binding Data
extension CurrencyRatesViewController {

    private func setUpBindings() {
        func bindViewToViewModel() {
          
            currencyBaseTextLabel.text.publisher
                .removeDuplicates()
                .sink { [weak viewModel] in
                    viewModel?.fetchCurrencyRates(with: $0)
                }
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            viewModel.$currencyRates
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    self?.reloadData()
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
extension CurrencyRatesViewController {
    func showError(message: String?) {
        displayMessage(title: "Something went wrong!", message: message)
    }

    func startLoading() {
        activityIndicator.startAnimating()
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
    }

    func reloadData() {
        currencyRatesTableView.reloadData()
    }

}
// MARK: - TableViewDataSource
extension CurrencyRatesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currencyRates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: CurrencyRateTableViewCell.self)
        let currencyRate = viewModel.currencyRates[indexPath.row]
        cell.viewModel = CurrencyCellViewModel(currencyRate: currencyRate)
        return cell
    }
}
// MARK: - TableViewDelegate
extension CurrencyRatesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRate = viewModel.currencyRates[indexPath.row]
        print("selectedRate = \(selectedRate.symbol) \(selectedRate.rate)")
    }
    
}
