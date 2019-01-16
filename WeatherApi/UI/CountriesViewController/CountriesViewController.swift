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
    
    var model = WeatherData()

    private let urlCountry = URL(string: "https://restcountries.eu/rest/v2/all")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Countries"
        
        self.rootView?.tableView?.register(CountryTableViewCell.self)
        self.rootView?.tableView?.dataSource = self
        self.rootView?.tableView?.delegate = self
    
        self.model.loadCountryData(urlCountry)
        
        model.observer {
            switch $0 {
                
            case .none:
                return
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
        return self.model.modelCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self
            .rootView?
            .tableView?
            .dequeueReusableCell(withCellClass: CountryTableViewCell.self) as? CountryTableViewCell
        
        let item = self.model.modelCountry[indexPath.row]
        cell?.fillWithModel(model: item)
        
        self.model.observer {
            switch $0 {
            case .none:
                return
            case .weatherChange:
                cell?.addDateandTemp(model: self.model)
            case .countryChange:
                return
            }
        }
        
        return cell ?? CountryTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.model.loadWeatherData(city: self.model.modelCountry[indexPath.row].capital) {
            self.navigationController?.pushViewController($0, animated: true)
        }
    }
    
//    private func loadData() {
//        let parser = Parser<[Country]>()
//
//        if let url = urlCountry {
//            parser.dataLoading(url: url)
//
//            parser.observer {
//                switch $0 {
//                case .none:
//                    return
//                case .didStartLoading:
//                    return
//                case .didLoad:
//                    guard let model = parser.model else { return }
//                    self.model.modelCountry = model.filter { $0.capital.count > 0 }
//                case .didFailedWithError(_):
//                    print("Error")
//                }
//            }
//        }
//    }
}
