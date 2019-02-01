//
//  DataModels.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/16/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class DataModels: ObservableObject<DataModels.Event> {

    enum Event {
        case didChangedCountry(Country?)
        case didDeletedCountry(Country)
        case didAddedCountry(Country)
    }
    
    var values: [Country]
    
    init(values: [Country] = []) {
        self.values = values
        
        super.init()
        
        self.prepareNotification()
    }
    
//    convenience init(countries: [Country]) {
//        self.init(values: countries.map(DataModel.init))
//    }
    
    func add(values: [Country]) {
        self.values = values
        self.notify(.didChangedCountry(nil))
    }
    
    func removeAll() {
        self.values = []
    }
    
    subscript(index: Int) -> Wrapper<Country> {
        get { return Wrapper(self.values[index]) }
//        set { self.values[index] = newValue }
    }
    
    func prepareNotification() {
        self.values.forEach { [weak self] model in
            (self?.notify).do { model.observer(handler: $0) }
        }
    }
}
