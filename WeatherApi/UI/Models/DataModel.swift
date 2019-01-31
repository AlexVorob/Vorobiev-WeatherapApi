//
//  DataModel.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/21/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class DataModel: ObservableObject<DataModel.Event> {
    
    enum Event {
        case didCountryChanged(Country)
        case didWeatherChanged(Weather?)
    }
    
    let countryWrapper: Wrapper<Country>
    let weatherWrapper: Wrapper<Weather?>
    
    init(country: Country, weather: Weather? = nil) {
        self.countryWrapper = Wrapper(country)
        self.weatherWrapper = Wrapper(weather)
        
        super.init()
        
        self.prepareNotification()
    }
    
    convenience init(country: Country) {
        self.init(country: country, weather: nil)
    }
    
    func prepareNotification() {
        _ = self.countryWrapper.observer { country in
            self.notify(.didCountryChanged(country))
        }
        
        _ = self.weatherWrapper.observer { weather in
            self.notify(.didWeatherChanged(weather))
        }
    }
}
