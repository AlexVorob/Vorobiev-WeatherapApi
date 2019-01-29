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
    
    private let countriesManager = CountriesManager()
    
    private var model = DataModel() {
        didSet {
            self.dispatchOnMain()
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Constant.title
        
        self.rootView?.tableView?.register(CountryTableViewCell.self)
        
        self.modelFilling()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: CountryTableViewCell.self, for: indexPath) {
            $0.fillWithModel(model: self.model.values[indexPath.row])
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let baseModelItem = self.model.values[indexPath.row]
        let weatherViewController = WeatherViewController(baseModelItem)
        
        self.navigationController?.pushViewController(weatherViewController, animated: true)
    }
    
    private func dispatchOnMain() {
        DispatchQueue.main.async {
            self.rootView?.tableView?.reloadData()
        }
    }
    
    private func modelFilling() {
        self.countriesManager.loadData {
            let data = $0.map {
                BaseModel(country: $0)
            }
            self.model.observer {
                switch $0 {
                case .didCountryChanged(_): self.dispatchOnMain()
                case .didWeatherChanged(_): break
                }
            }
            
            self.model = DataModel(values: data)
        }
    }
}
