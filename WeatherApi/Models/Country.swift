//
//  Country.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/25/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import RealmSwift

public class Country: ObservableObject<CountriesModel.Event> {
    
    public var weather: Weather? {
        didSet {
            self.notify(.didChangedCountry(nil))
        }
    }
    
    public let id: String
    public let name: String
    public let capital: String

    public init(id: String, name: String, capital: String, weather: Weather? = nil) {
        self.id = id
        self.name = name
        self.capital = capital
    }
}
