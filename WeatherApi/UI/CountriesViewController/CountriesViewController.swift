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
    
    var model = Countries() {
        didSet {
            DispatchQueue.main.async {
                self.rootView?.tableView?.reloadData()
            }
        }
    }
    
    private let reuseIdentifier = "cell"
    private let url = URL(string: "https://restcountries.eu/rest/v2/all")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.rootView?.tableView?.dataSource = self
        self.rootView?.tableView?.delegate = self
        
        self.parseCountries()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.rootView?.tableView?.dequeueReusableCell(withIdentifier: reuseIdentifier)
        
        let item = model.values[indexPath.row]
        cell?.textLabel?.text = ("\(item.name) - \(item.capital)")
        
        return cell!
    }
    
    struct Countries: Codable {
        var values = [Country]()
    }
    
    struct Country: Codable {
        let name: String
        let capital: String
    }
    
    func parseCountries() {
        if let url = self.url {
        URLSession.shared.dataTask(with: url) { (data, respose, error) in
            let countries = data.flatMap { try? JSONDecoder().decode([Country].self, from: $0) }
            countries.do { self.model.values = $0 }
    
            }.resume()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherView = WeatherViewController()
        
        self.navigationController?.pushViewController(weatherView, animated: true)
    }
}
