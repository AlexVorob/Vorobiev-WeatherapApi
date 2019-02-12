//
//  DataModels.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/16/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class CountriesModel: ObservableObject<CountriesModel.Event> {

    enum Event {
        case didChangedCountry(Country?)
        case didDeletedCountry(Country?)
        case didAppendCountry(Country?)
    }
    
    public var values: [Country]
    
    public var count: Int {
        return self.values.count
    }
    
    init(values: [Country] = []) {
        self.values = values
        
        super.init()
    }
    
    func add(values: [Country]) {
        self.values += values
        self.notify(.didAppendCountry(nil))
    }
    
    func append(country: Country) {
        self.values.append(country)
        self.notify(.didAppendCountry(country))
    }
    
    func removeAt(index: Int) {
        self.values.remove(at: index)
        self.notify(.didDeletedCountry(self.values[index]))
    }
    
    func removeAll() {
        self.values = []
    }
    
    subscript(index: Int) -> Country {
        
        get { return self.values[index] }
    }
}
