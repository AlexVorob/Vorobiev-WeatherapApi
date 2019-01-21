//
//  Model.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/16/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class Model {

    var values: [BaseModel]
    
    init(values: [BaseModel] = []) {
        self.values = values
    }
}
