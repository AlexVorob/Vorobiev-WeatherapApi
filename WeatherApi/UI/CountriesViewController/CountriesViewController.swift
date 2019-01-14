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
    
    private let reuseIdentifier = "cell"
    private let urlCountry = URL(string: "https://restcountries.eu/rest/v2/all")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.rootView?.tableView?.dataSource = self
        self.rootView?.tableView?.delegate = self
        
        let parser = Parser<[Country]>()
        if let url = urlCountry {
            parser.parse(url: url)
        
            parser.observer {
                switch $0 {
                case .none:
                    return
                case .didStartLoading:
                    return
                case .didLoad:
                    self.model = parser.model!
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
        let cell = self.rootView?.tableView?.dequeueReusableCell(withIdentifier: reuseIdentifier)
        
        let item = self.model[indexPath.row]
        cell?.textLabel?.text = ("\(item.name) - \(item.capital)")
        
        return cell ?? UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherViewController = WeatherViewController()
        weatherViewController.city = self.model[indexPath.row].capital
        
        self.navigationController?.pushViewController(weatherViewController, animated: true)
    }
}
