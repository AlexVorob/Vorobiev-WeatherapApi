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
    static let errorInit = "init(coder:) has not been implemented"
}

class CountriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RootViewRepresentable {
    
    typealias RootView = CountriesView
    
    private let countriesManager = CountriesManager()
    
    private var model = DataModels() {
        didSet {
            self.dispatchOnMain()
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(Constant.errorInit)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Constant.title
        
        self.rootView?.tableView?.register(CountryTableViewCell.self)
        
        self.modelFill()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: CountryTableViewCell.self, for: indexPath) {
            $0.fillWithModel(self.model.values[indexPath.row])
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
    
    private func modelFill() {
        self.countriesManager.loadData {
            let data = DataModels(values: $0.map(DataModel.init))
            
            data.observer { _ in
               self.dispatchOnMain()
            }
            
            self.model = data
        }
    }
}
