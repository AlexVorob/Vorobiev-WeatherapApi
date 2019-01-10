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
    
    let reuseIdentifier = "cell"
    let url = URL(string: "https://restcountries.eu/rest/v2/all")
    
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
        cell?.textLabel?.text = item.name
        
        return cell!
    }
    
    struct Countries: Codable {
        var values = [Country]()
    }
    
    struct Country: Codable {
        var name: String
        var capital: String
    }
    
    func parseCountries() {
        if let url = self.url {
        URLSession.shared.dataTask(with: url) { (data, respose, error) in
            guard let data = data else { return }
            do {
                let countries = try JSONDecoder().decode([Country].self, from: data)
                self.model.values = countries
                
            } catch let jsonError {
                print("Error", jsonError)
            }
            }.resume()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(self.model.values[indexPath.row])")
    }
}
