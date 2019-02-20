//
//  CountriesViewController.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import RealmSwift

fileprivate struct Constant {
    
    static let title = "Countries"
}

class CountriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RootViewRepresentable {
    
    typealias RootView = CountriesView
    
    private let countriesNetworkService: CountriesNetworkService
    private let countriesModel: CountriesModel
    private let cancelableObserver = CancellableProperty()
    private let cancellableNetworkTask = CancellableProperty()

    init(countriesNetworkService: CountriesNetworkService, model: CountriesModel) {
        
        self.countriesNetworkService = countriesNetworkService
        self.countriesModel = model
        
        super.init(nibName: nil, bundle: nil)
        
        self.cancelableObserver.value = self.countriesModel.observer { [weak self] in
            switch $0 {
            case .didChangedCountry: break
            case .didDeletedCountry: break
            case .didAppendCountry:
                performOnMain {
                    self?.rootView?.tableView?.reloadData()
                }
            }
        }
        
        self.countriesModel.append(country: Country(id: "UA", name: "Ukraine", capital: "Kryvyy Rih"))
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
        return self.countriesModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(cellClass: CountryTableViewCell.self, for: indexPath) {
            
            let country = self.countriesModel.values[indexPath.row]
            
            $0.country = country
            $0.eventHandler = {
                switch $0 {
                case .updateCell:
                    performOnMain {
                        tableView.reloadRows(at: [indexPath], with: .automatic)
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = self.countriesModel[indexPath.row]

        let dataBaseService = DataBaseService<JSONWeatherRLM>()
        let requestService = RequestService(session: URLSession(configuration: .default))
        let weatherManager = WeatherNetworkService(requestService: requestService, dataBaseService: dataBaseService)
    
        let weatherViewController = WeatherViewController(weatherManager: weatherManager, country: country)
        
        self.navigationController?.pushViewController(weatherViewController, animated: true)
    }
    
    private func modelFill() {
        self.cancellableNetworkTask.value = self.countriesNetworkService.modelFilling(
            model: self.countriesModel
        )
    }
}
