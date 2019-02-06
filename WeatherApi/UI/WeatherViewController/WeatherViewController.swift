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
    
    private let weatherManager: WeatherNetworkService?
    private let country: ObservableWrapper<Country>
    
    init(_ weatherManager: WeatherNetworkService,_ country: ObservableWrapper<Country>) {
        self.weatherManager = weatherManager
        self.country = country
        
        super.init(nibName: nil, bundle: nil)
        
        self.country.observer {_ in
            dispatchOnMain {
                self.rootView?.fillWeather(with: self.country.unwrap)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("inivaroder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weatherManager?.modelFilling(country: self.country)
    }
}
