//
//  Country.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/25/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class Country {
    
    let name: String
    let capital: String
    
    init(json: JSONCountry) {
        self.name = json.name
        self.capital = json.capital
    }
}
