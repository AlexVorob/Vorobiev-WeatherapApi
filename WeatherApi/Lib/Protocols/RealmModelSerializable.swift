//
//  RealmModelSerializable.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 2/21/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

protocol RealmModelSerializable {
    
    associatedtype ConvertableType
    
    init(object: ConvertableType)
    
    func converted() -> ConvertableType
}
