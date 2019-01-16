//
//  WeatherData.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/16/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class WeatherData {
    
    var temperature: String?
    var city: String?
    
    private let api = "https://api.openweathermap.org/data/2.5/weather?q="
    private let apiID = "&units=metric&APPID=ac6d05234841cc6b76ed2a4fcfda2b6b"
    
    func getWeatherData(city: String, completion: @escaping (UIViewController) -> ()) {
        
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
                    parser.model?.main["temp"].do { self.temperature = String($0) }
                    self.city = city
                    let weatherViewController = WeatherViewController(self)
                    //weatherViewController.rootView?.fillWeather(city: city, temperature: self.temperature!)
                    completion(weatherViewController)
                case .didFailedWithError(_):
                    print("Error")
                }
            }
        }
    }
}
