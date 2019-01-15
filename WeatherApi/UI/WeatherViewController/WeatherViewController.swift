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
    
    var temperature: Double?
    var city: String?
    
    var model: Weather?
 
    private let api = "https://api.openweathermap.org/data/2.5/weather?q="
    private let apiID = "&units=metric&APPID=ac6d05234841cc6b76ed2a4fcfda2b6b"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let city = self.city else { return }
        
        self.rootView?.country?.text = city
        
        let weatherPath = api + city + apiID
        let url = weatherPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let urlWeather = URL(string: url!)

        let parser = Parser<Weather>()
        if let url = urlWeather {
            parser.dataLoading(url: url)
            
            parser.observer {
                switch $0 {
                case .none:
                    return
                case .didStartLoading:
                    return
                case .didLoad:
                    guard let model = parser.model else { return }
                    self.model = model
                    self.rootView?.temperature?.text = String(model.main["temp"]!)
                case .didFailedWithError(_):
                    print("Error")
                }
            }
        }
    }
}
