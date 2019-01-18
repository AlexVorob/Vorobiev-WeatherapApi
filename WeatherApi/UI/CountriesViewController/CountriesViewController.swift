//
//  CountriesViewController.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RootViewRepresentable {
    
    typealias RootView = CountriesView
    
    var model = Model()

    private let urlCountry = URL(string: "https://restcountries.eu/rest/v2/all")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Countries"
        
        self.rootView?.tableView?.register(CountryTableViewCell.self)
        self.rootView?.tableView?.dataSource = self
        self.rootView?.tableView?.delegate = self
    
        self.loadCountryData()
        
        self.model.observer {
            switch $0 {
            case .weatherChange:
                return
            case .countryChange:
                DispatchQueue.main.async {
                    self.rootView?.tableView?.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self
            .rootView?
            .tableView?
            .dequeueReusableCell(withCellClass: CountryTableViewCell.self) as? CountryTableViewCell
        
        let item = self.model.values[indexPath.row]
        cell?.fillWithModel(model: item)
        
//        self.model.observer {
//            switch $0 {
//            case .weatherChange:
//                cell?.addDateandTemp(model: self.model)
//            case .countryChange:
//                return
//            }
//        }
        
        return cell ?? CountryTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = self.model.values[indexPath.row].country.capital
        let weatherViewController = WeatherViewController(self.model, city: city)
            self.navigationController?.pushViewController(weatherViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    func loadCountryData() {
        guard let url = urlCountry else { return }
        
        let network = NetworkService<[Country]>()
        network.dataLoad(url: url)
//        self.model.notify(state: .countryChange)
        network.observer {
            switch $0 {
            case .didStartLoading:
                return
            case .didLoad:
                let modelCountry = network.model?.filter { $0.capital.count > 0 }
                modelCountry?.forEach {
                    self.model.values.append(AbstractModel(country: $0))
                }
                DispatchQueue.main.async {
                    self.rootView?.tableView?.reloadData()
                }
            case .didFailedWithError(_):
                return
            }
        }
    }
}
