//
//  WeatherViewController.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

fileprivate struct Constant {
    
    static let errorInit = "init(coder:) has not been implemented"
}

class WeatherViewController: UIViewController, RootViewRepresentable {

    typealias RootView = WeatherView
    
    private let dataModel: DataModel
    
    init(_ dataModel: DataModel) {
        self.dataModel = dataModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(Constant.errorInit)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherManager().loadData(dataModel: dataModel) { weather in
            let model = self.dataModel
            model.weatherWrapper.value = weather
            
            dispatchOnMain {
                self.rootView?.fillWeather(with: model)
            }
        }
    }
}
