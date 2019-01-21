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
    
    private let managerController = ManagerController<[Country]>()
    
    var model = Model() {
        didSet {
            DispatchQueue.main.async {
                self.rootView?.tableView?.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Countries"
        
        self.rootView?.tableView?.register(CountryTableViewCell.self)
        self.rootView?.tableView?.dataSource = self
        self.rootView?.tableView?.delegate = self
    
        self.loadCountryData()
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
        
        return cell ?? CountryTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let baseModelItem = self.model.values[indexPath.row]
        let weatherViewController = WeatherViewController(self.model, baseModelItem)
        
        self.navigationController?.pushViewController(weatherViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.rootView?.tableView?.reloadData()
        }
    }

    func loadCountryData() {
        let urlCountry = URL(string: Constant.countryApi)
        guard let url = urlCountry else { return }
        
        self.managerController.loadData(from: url) { model, error in
            guard let item = model else { return }
            
            let itemModel = Model()
            itemModel.values = item.filter { $0.capital.count > 0 }.map(BaseModel.init)
            
            self.model = itemModel
        }
    }
}
