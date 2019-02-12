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
    
    private let weatherNetworkService: WeatherNetworkService
    private let country: Country
    private let cancellableWeatherObserver = CancellableProperty()
    
    init(weatherManager: WeatherNetworkService, country: Country) {
        
        self.weatherNetworkService = weatherManager
        self.country = country
        
        super.init(nibName: nil, bundle: nil)
        
        self.cancellableWeatherObserver.value = self.country.observer {_ in
            performOnMain {
                self.rootView?.fillWeather(with: self.country)
            }
        }
        
        self.weatherNetworkService.modelFilling(country: self.country)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("inivaroder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.fillWeather(with: self.country)
    }
}
