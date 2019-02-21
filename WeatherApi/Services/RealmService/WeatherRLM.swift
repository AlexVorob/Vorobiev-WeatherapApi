//
//  WeatherRLM.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 2/21/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class WeatherRLM: RLMModel, RealmModelSerializable {
    
    @objc dynamic var temperature = 0.0
    @objc dynamic var date = Date()
    
    convenience init(id: String, temperature: Double, date: Date) {
        self.init()
        self.id = id
        self.temperature = temperature
        self.date = date
    }
    
    required convenience init(object: Weather) {
        self.init(id: object.id, temperature: object.temperature, date: object.date)
    }
    
    func converted() -> Weather {
        return Weather(date: self.date, temperature: self.temperature, id: self.id)
    }
}
