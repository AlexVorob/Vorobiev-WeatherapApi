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
    
    private let model: Model
    
    private(set) var city: String
    private let celsius = "°C"
    
    private let api = "https://api.openweathermap.org/data/2.5/weather?q="
    private let apiID = "&units=metric&APPID=ac6d05234841cc6b76ed2a4fcfda2b6b"
    
    init(_ model: Model, city: String) {
        self.model = model
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadWeatherData()
    }
    
    func loadWeatherData() {
        let weatherPath = api + city + apiID
        let url = weatherPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlWeather = url else { return }
        let safeUrlWeather = URL(string: urlWeather)
        
        let parser = NetworkService<Weather>()
        if let url = safeUrlWeather {
            parser.dataLoad(url: url)
            
            parser.observer {
                switch $0 {
                case .didStartLoading:
                    return
                case .didLoad:
                    // save to model
                    DispatchQueue.main.async {
                        parser.model?.main.temp.do { self.rootView?.temperature?.text = String($0) + self.celsius }
                        self.rootView?.country?.text = self.city
                    }
                    self.model.notify(state: .weatherChange)
                case .didFailedWithError(_):
                    print("Error")
                }
            }
        }
    }
}
