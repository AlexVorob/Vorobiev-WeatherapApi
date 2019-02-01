//
//  Country.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/25/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class Country: ObservableObject<DataModels.Event> {
    
    var weather: Weather?
    
    let name: String
    let capital: String

    init(json: JSONCountry, weather: Weather?) {
        self.name = json.name
        self.capital = json.capital
        self.weather = nil
        
        super.init()
        
        self.prepareNotification()
    }
    
    func prepareNotification() {
        self.weather?.observer { weather in
            self.notify(.didChangedCountry(self))
        }
    }
}
