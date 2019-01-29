//
//  BaseModel.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/21/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class BaseModel: ObservableObject<BaseModel.BaseModelEvents> {
    
    enum BaseModelEvents {
        case didCountryChanged(Country)
        case didWeatherChanged(Weather?)
    }
    
    var country: Wrapper<Country>
    var weather: Wrapper<Weather?>
    
    init(country: Country, weather: Weather? = nil) {
        self.country = Wrapper(country)
        self.weather = Wrapper(weather)
        super.init()
        
        self.prepareNotification()
    }
    
    func prepareNotification() {
        _ = self.country.observer { country in
            self.notify(state: .didCountryChanged(country))
        }
        
        _ = self.weather.observer { weather in
            self.notify(state: .didWeatherChanged(weather))
        }
    }
}
