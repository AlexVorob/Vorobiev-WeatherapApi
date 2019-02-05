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
    
    private let weatherManager: WeatherManager?
    private let country: Wrapper<Country>
    
    init(_ weatherManager: WeatherManager,_ country: Wrapper<Country>) {
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
        
        self.weatherManager?.loadData(country: self.country)
    }
}
