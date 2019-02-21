//
//  CountryRLM.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 2/21/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

fileprivate let providerID = autoIncrementedID(0)

class CountryRLM: RLMModel, RealmModelSerializable {
    
    @objc dynamic var name = ""
    @objc dynamic var capital = ""
    
    @objc dynamic var weather: WeatherRLM?
    
    convenience init(id: String, name: String, capital: String, weather: Weather?) {
        self.init()
        self.id = id
        self.name = name
        self.capital = capital
        self.weather = weather.map(WeatherRLM.init)
    }
    
    required convenience init(object: Country) {
        self.init(id: object.id, name: object.name, capital: object.capital, weather: object.weather)
    }
    
    func converted() -> Country {
        return Country(id: self.id, name: self.name, capital: self.capital)
    }
}
