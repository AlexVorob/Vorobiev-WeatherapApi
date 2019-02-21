//
//  RLMModel.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 2/21/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import RealmSwift

public class RLMModel: Object {
    
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var id = ""
}
