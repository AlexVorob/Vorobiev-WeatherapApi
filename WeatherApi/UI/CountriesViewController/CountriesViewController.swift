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
    
    var model = [Country]() {
        didSet {
            DispatchQueue.main.async {
                self.rootView?.tableView?.reloadData()
            }
        }
    }
    
    private let urlCountry = URL(string: "https://restcountries.eu/rest/v2/all")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Countries"
        
        self.rootView?.tableView?.register(CountryTableViewCell.self)
        self.rootView?.tableView?.dataSource = self
        self.rootView?.tableView?.delegate = self
        
        let parser = Parser<[Country]>()
        
        if let url = urlCountry {
            parser.dataLoading(url: url)
        
            parser.observer {
                switch $0 {
                case .none:
                    return
                case .didStartLoading:
                    return
                case .didLoad:
                    guard let model = parser.model else { return }
                    self.model = model.filter { $0.capital.count > 0 }
                case .didFailedWithError(_):
                    print("Error")
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self
            .rootView?
            .tableView?
            .dequeueReusableCell(withCellClass: CountryTableViewCell.self) as? CountryTableViewCell
        
        let item = self.model[indexPath.row]
        cell?.fillWithModel(model: item)
        
        return cell ?? CountryTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherData = WeatherData()
        weatherData.getWeatherData(city: self.model[indexPath.row].capital) {
            self.navigationController?.pushViewController($0, animated: true)
        }
    }
}
