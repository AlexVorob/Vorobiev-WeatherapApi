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
    
    var temperature: Int?
    var city: String?
    
    var model = Weather() /*{
        didSet {
            DispatchQueue.main.async {
                self.rootView?.label
            }
        }
    }*/
    
    private let api = "https://api.openweathermap.org/data/2.5/weather?q="
    private let apiID = "&units=metric&APPID=ac6d05234841cc6b76ed2a4fcfda2b6b"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let city = self.city else { return }
        self.rootView?.label?.text = city
        let urlWeather = URL(string: api + city + apiID)
        
        let parser = Parser<Weather>()
        if let url = urlWeather {
            parser.parse(url: url)
            
            parser.observer {
                switch $0 {
                case .none:
                    return
                case .didStartLoading:
                    return
                case .didLoad:
                    self.model = parser.model!
                    self.rootView?.label2?.text = String(self.model.main["temp"]!)
                case .didFailedWithError(_):
                    print("Error")
                }
            }
        }
    }
    
    
}
