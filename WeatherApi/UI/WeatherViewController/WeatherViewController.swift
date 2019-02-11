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
    private let countryObservableWrapper: ObservableWrapper<Country>
    private let cancellableWeatherObserver = CancellableProperty()
    
    init(weatherManager: WeatherNetworkService, country: ObservableWrapper<Country>) {
        
        self.weatherNetworkService = weatherManager
        self.countryObservableWrapper = country
        
        super.init(nibName: nil, bundle: nil)
        
        self.cancellableWeatherObserver.value = self.countryObservableWrapper.observer {_ in
            performOnMain {
                self.rootView?.fillWeather(with: self.countryObservableWrapper.unwrap)
            }
        }
        
        self.weatherNetworkService.modelFilling(country: self.countryObservableWrapper)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("inivaroder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.weatherNetworkService.modelFilling(country: self.countryObservableWrapper)
        self.rootView?.fillWeather(with: self.countryObservableWrapper.unwrap)
    }
}
