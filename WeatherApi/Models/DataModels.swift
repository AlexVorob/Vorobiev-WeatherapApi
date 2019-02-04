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
    
    private var values: [Country]
    
    public var count: Int {
        return self.values.count
    }
    
    init(values: [Country] = []) {
        self.values = values
        
        super.init()
        
        //self.prepareNotification()
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
        get {
            let wrapper = Wrapper(self.values[index])
            wrapper.observer {
                self.notify(.didChangedCountry($0))
            }
            
            return wrapper
        }
        set {
            self.values[index] = newValue.unWrap
            self.notify(.didChangedCountry(newValue.unWrap))
        }
    }
    
//    func prepareNotification() {
//        self.values.forEach { [weak self] model in
//            (self?.notify).do { model.observer(handler: $0) }
//        }
//    }
}
