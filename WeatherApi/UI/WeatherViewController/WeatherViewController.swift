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
    
    private var weatherNetworkService: WeatherNetworkService {
        didSet {
            self.weatherNetworkService.modelFilling(country: self.countryObservableWrapper)
        }
    }
    
    private var countryObservableWrapper: ObservableWrapper<Country> {
        didSet {
            dispatchOnMain {
                self.rootView?.fillWeather(with: self.countryObservableWrapper.unwrap)
            }
        }
    }
    
    private let cancellableWeatherObserver = CancellableProperty()
    
    init(_ weatherManager: WeatherNetworkService,_ country: ObservableWrapper<Country>) {
        self.weatherNetworkService = weatherManager
        self.countryObservableWrapper = country
        
        super.init(nibName: nil, bundle: nil)
        
        self.cancellableWeatherObserver.value = self.countryObservableWrapper.observer {_ in
            dispatchOnMain {
                self.rootView?.fillWeather(with: self.countryObservableWrapper.unwrap)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("inivaroder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weatherNetworkService.modelFilling(country: self.countryObservableWrapper)
    }
}
