//
//  WeatherViewController.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, RootViewRepresentable {

    typealias RootView = WeatherView
    
    private let model: BaseModel
    private let managerController = ManagerController<Weather>()
    
    init(_ model: Model,_ baseModelItem: BaseModel) {
        self.model = baseModelItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadWeatherData()
    }
    
    private func getURL() -> URL? {
        let weatherPath = Constant.getApiLink(model.country.capital)
        let urlWeather = weatherPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let url = urlWeather else { return nil }
           return URL(string: url)
    }
    
    private func loadWeatherData() {
        guard let url = self.getURL() else { return }
        
        self.managerController.loadData(from: url) { model, error in
            self.model.weather = model
            self.model.date = Date()
            
            DispatchQueue.main.async {
                self.rootView?.fillWeather(model: self.model)
            }
        }
    }
}
