//
//  CountriesViewController.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

fileprivate struct Constant {
    
    static let title = "Countries"
}

class CountriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RootViewRepresentable {
    
    typealias RootView = CountriesView
    
    private let countriesManager: CountriesManager
    private let networkService: NetworkService<[JSONCountry]>
    private var model: DataModels
    
    private var cancelable = CancellableProperty()

    init(countriesManager: CountriesManager, networkService: NetworkService<[JSONCountry]>, model: DataModels) {
        
        self.countriesManager = countriesManager
        self.networkService = networkService
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        
        self.cancelable.value = self.model.observer {
            switch $0 {
            case .didChangedCountry(_): break
            case .didDeletedCountry(_): break
            case .didAppendCountry(_):
                dispatchOnMain {
                    self.rootView?.tableView?.reloadData()
                }
            }
        }
        
        self.model.append(country: Country(name: "Ukraine", capital: "Kryvyy Rih", weather: nil))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Constant.title
        
        self.rootView?.tableView?.register(CountryTableViewCell.self)
        
        self.modelFill()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: CountryTableViewCell.self, for: indexPath) {
            $0.fillWithModel(self.model[indexPath.row].unwrap)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = self.model[indexPath.row]
        
        country.observer {_ in
            dispatchOnMain {
                self.rootView?.tableView?.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        let networkService = NetworkService<JSONWeather>()
        let weatherManager = WeatherManager(networkService)
        let weatherViewController = WeatherViewController(weatherManager, country)
        
        self.navigationController?.pushViewController(weatherViewController, animated: true)
    }
    
    private func modelFill() {
        self.countriesManager.loadData(networkService: self.networkService, model: self.model)
    }
}
