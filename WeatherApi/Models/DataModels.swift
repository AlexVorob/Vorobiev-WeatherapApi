//
//  DataModels.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/16/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class DataModels: ObservableObject<DataModel.Event> {

    let values: [DataModel]
    
    init(values: [DataModel] = []) {
        self.values = values
        
        super.init()
        
        self.prepareNotification()
    }
    
    convenience init(countries: [Country]) {
        self.init(values: countries.map(DataModel.init))
    }
    
    func prepareNotification() {
        self.values.forEach { [weak self] model in
            (self?.notify).do { model.observer(handler: $0) }
        }
    }
}
