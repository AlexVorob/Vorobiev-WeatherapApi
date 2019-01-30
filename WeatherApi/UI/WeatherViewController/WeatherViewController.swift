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
    
    private let baseModel: BaseModel
    
    init(_ baseModel: BaseModel) {
        self.baseModel = baseModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherManager().loadData(baseModel: baseModel) { weather in
            let model = self.baseModel
            model.weather.value = weather
            
            DispatchQueue.main.async {
                self.rootView?.fillWeather(model: model)
            }
        }
    }
}
