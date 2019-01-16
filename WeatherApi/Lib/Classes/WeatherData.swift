//
//  WeatherData.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/16/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class WeatherData: ObservableObject<WeatherData.StateWeather> {
    
    public enum StateWeather {
        case none
        case weatherChange
        case countryChange
    }
    
    private(set) var stateWeather = StateWeather.none {
        didSet {
            DispatchQueue.main.async {
                self.notify(state: self.stateWeather)
            }
        }
    }
    
    var modelCountry = [Country]() {
        didSet {
            DispatchQueue.main.async {
                self.notify(state: self.stateWeather)
            }
        }
    }
    
    private(set) var temperature: String?
    private(set) var city: String?
    private let celsius = "°C"
    
    private let api = "https://api.openweathermap.org/data/2.5/weather?q="
    private let apiID = "&units=metric&APPID=ac6d05234841cc6b76ed2a4fcfda2b6b"
    
    func loadCountryData(_ urlCountry: URL?) {
        let parser = Parser<[Country]>()
        
        if let url = urlCountry {
            parser.dataLoading(url: url)
            
            parser.observer {
                switch $0 {
                case .none:
                    return
                case .didStartLoading:
                    return
                case .didLoad:
                    guard let model = parser.model else { return }
                    self.modelCountry = model.filter { $0.capital.count > 0 }
                    self.stateWeather = .countryChange
                case .didFailedWithError(_):
                    print("Error")
                }
            }
        }
    }
    
    func loadWeatherData(city: String, completion: @escaping (UIViewController) -> ()) {
        
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
                    parser.model?.main["temp"].do { self.temperature = String($0) + self.celsius }
                    self.city = city
                    self.stateWeather = .weatherChange
                    let weatherViewController = WeatherViewController(self)
                    completion(weatherViewController)
                case .didFailedWithError(_):
                    print("Error")
                }
            }
        }
    }
}
