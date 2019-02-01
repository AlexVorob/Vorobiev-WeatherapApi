//
//  WeatherViewController.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

fileprivate struct Constant {
    
    static let errorInit = "inivaroder:) has not been implemented"
}

class WeatherViewController: UIViewController, RootViewRepresentable {

    typealias RootView = WeatherView
    
    private let weatherManager: WeatherManager?
    
    init(_ weatherManager: WeatherManager) {
        self.weatherManager = weatherManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(Constant.errorInit)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weatherManager?.loadData() { country in
//            let model = self.country
//            model.weather = weather
            
            dispatchOnMain {
                self.rootView?.fillWeather(with: country)
            }
        }
    }
}
