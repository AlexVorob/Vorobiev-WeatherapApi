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
    
//    private var model = Model() {
//        didSet {
//            dispatchOnMain {
//                self.rootView?.tableView?.reloadData()
//            }
//        }
//    }

    init() {
        self.countriesManager.loadData()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Constant.title
        
        self.rootView?.tableView?.register(CountryTableViewCell.self)
    
        dispatchOnMain {
            self.rootView?.tableView?.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countriesManager.model.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: CountryTableViewCell.self, for: indexPath) {
            $0.fillWithModel(model: self.countriesManager.model.values[indexPath.row])
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let baseModelItem = self.countriesManager.model.values[indexPath.row]
        let weatherViewController = WeatherViewController(baseModelItem)
        
        self.navigationController?.pushViewController(weatherViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dispatchOnMain {
            self.rootView?.tableView?.reloadData()
        }
    }
}

//    func loadCountryData() {
//        let urlCountry = URL(string: Constant.countryApi)
//        guard let url = urlCountry else { return }
//
//        self.dataManager.loadData(from: url) { model, error in
//            if error != nil {
//                print(error?.localizedDescription ?? "")
//            } else {
//                guard let item = model else { return }
//
//                let itemModel = Model()
//                itemModel.values = item
//                    .filter { $0.capital.count > 0 }
//                    .map { BaseModel(country: Country(json: $0)) }
//
//                self.model = itemModel
//            }
//        }
//    }
